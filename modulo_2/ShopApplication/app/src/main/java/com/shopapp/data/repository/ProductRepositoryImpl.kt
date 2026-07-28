// data/repository/ProductRepositoryImpl.kt
package com.shopapp.data.repository

import android.content.Context
import android.net.Uri
import dagger.hilt.android.qualifiers.ApplicationContext
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.RequestBody.Companion.asRequestBody
import com.shopapp.data.remote.api.ProductApi
import com.shopapp.data.remote.dto.RestockRequestDto
import com.shopapp.data.remote.dto.toDomain
import com.shopapp.data.remote.dto.toRequest
import com.shopapp.domain.model.Product
import com.shopapp.domain.model.ProductFilters
import com.shopapp.domain.model.ProductPayload
import com.shopapp.domain.repository.ProductRepository
import java.io.File
import java.io.FileOutputStream
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class ProductRepositoryImpl @Inject constructor(
    private val api: ProductApi,
    @ApplicationContext private val context: Context,
) : ProductRepository {

    override suspend fun getProducts(filters: ProductFilters): Result<Pair<List<Product>, Int>> =
        runCatching {
            val params = buildMap<String, String> {
                filters.search?.let   { put("search",    it) }
                filters.category?.let { put("category",  it.toString()) }
                filters.priceMin?.let { put("price_min", it.toString()) }
                filters.priceMax?.let { put("price_max", it.toString()) }
                filters.stockMin?.let { put("stock_min", it.toString()) }
                filters.isActive?.let { put("is_active", it.toString()) }
                filters.ordering?.let { put("ordering",  it) }
                put("page",      filters.page.toString())
                put("page_size", filters.pageSize.toString())
            }
            val response = api.getProducts(params)
            if (response.isSuccessful) {
                val body = response.body()!!
                Pair(body.results.map { it.toDomain() }, body.count)
            } else error("Error ${response.code()}")
        }

    override suspend fun getProduct(id: Int): Result<Product> = runCatching {
        val response = api.getProduct(id)
        if (response.isSuccessful) response.body()!!.toDomain()
        else error("Error ${response.code()}")
    }

    override suspend fun createProduct(payload: ProductPayload): Result<Product> = runCatching {
        val response = api.createProduct(payload.toRequest())
        if (response.isSuccessful) response.body()!!.toDomain()
        else error("Error ${response.code()}: ${response.errorBody()?.string()}")
    }

    override suspend fun updateProduct(id: Int, payload: ProductPayload): Result<Product> =
        runCatching {
            val response = api.updateProduct(id, payload.toRequest())
            if (response.isSuccessful) response.body()!!.toDomain()
            else error("Error ${response.code()}: ${response.errorBody()?.string()}")
        }

    override suspend fun deleteProduct(id: Int): Result<Unit> = runCatching {
        val response = api.deleteProduct(id)
        if (!response.isSuccessful) error("Error ${response.code()}")
    }

    override suspend fun restock(id: Int, quantity: Int): Result<Int> = runCatching {
        val response = api.restock(id, RestockRequestDto(quantity))
        if (response.isSuccessful) response.body()!!.newStock
        else error("Error ${response.code()}")
    }

    override suspend fun getStats(): Result<Map<String, Any>> = runCatching {
        val response = api.getStats()
        if (response.isSuccessful) {
            val s = response.body()!!
            mapOf(
                "total_active"   to s.totalActive,
                "total_inactive" to s.totalInactive,
                "avg_price"      to (s.avgPrice ?: 0.0),
                "total_stock"    to (s.totalStock ?: 0),
                "out_of_stock"   to s.outOfStock,
            )
        } else error("Error ${response.code()}")
    }

    override suspend fun uploadProductImage(
        productId: Int,
        uri: Uri
    ): Result<String> = runCatching {
        val file = uriToFile(uri)

        val requestFile = file.asRequestBody("image/*".toMediaTypeOrNull())
        val imagePart = MultipartBody.Part.createFormData(
            name = "image",
            filename = file.name,
            body = requestFile,
        )

        val response = api.uploadProductImage(productId, imagePart)

        // Limpiamos el archivo temporal sin importar el resultado
        file.delete()

        if (response.isSuccessful) {
            response.body()?.imageUrl
                ?: error("La respuesta no incluyó la URL de la imagen")
        } else {
            error("Error ${response.code()}: ${response.errorBody()?.string()}")
        }
    }

    /**
     * Copia el contenido del Uri (content://...) a un archivo temporal
     * en el caché de la app, porque Retrofit/OkHttp necesita un File real
     * para construir el MultipartBody.Part.
     */
    private fun uriToFile(uri: Uri): File {
        val inputStream = context.contentResolver.openInputStream(uri)
            ?: error("No se pudo abrir el archivo seleccionado")

        val tempFile = File(context.cacheDir, "upload_${System.currentTimeMillis()}.jpg")

        inputStream.use { input ->
            FileOutputStream(tempFile).use { output ->
                input.copyTo(output)
            }
        }

        return tempFile
    }
}