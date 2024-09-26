library(loadings)
library(plumber)

# Title
#* @apiTitle Loadings Web API Sample
# Description
#* @apiDescription This web api is loadings web api sample
# TOS link
#* @apiTOS
# Contact object
#* @apiContact list(name = "Myxogastria0808", url = "https://github.com/Myxogastria0808/loadings-web-api-sample", email = "r.rstudio.c@gmail.com")
# License object
#* @apiLicense list(name = "Apache 2.0", url = "https://www.apache.org/licenses/LICENSE-2.0.html")
# Version
#* @apiVersion 0.0.1
# Tag Description
#* @apiTag loadings "Loadings Web API Sample"


#* @filter cors
cors <- function(req, res) {
    res$setHeader("Access-Control-Allow-Origin", "*")
    if (req$REQUEST_METHOD == "OPTIONS") {
        res$setHeader("Access-Control-Allow-Methods", "GET")
        res$setHeader(
        "Access-Control-Allow-Headers",
        req$HTTP_ACCESS_CONTROL_REQUEST_HEADERS
        )
        res$status <- 200
        return(list())
    } else {
        plumber::forward()
    }
}

#* 主成分分析の因子負荷量の検定
#* ```
#* > function() {
#* >    data(fasting) # テストデータ読み込み
#* >    pca <- prcomp(fasting$X, scale=TRUE) # 主成分分析
#* >    pca <- pca_loading(pca) # 主成分分析の因子負荷量の検定
#* >    biplot(pca)
#* > }
#* ```
#* @serializer png list(width=800, height=800)
#* @get /pca
function() {
    data(fasting) # テストデータ読み込み
    pca <- prcomp(fasting$X, scale=TRUE) # 主成分分析
    pca <- pca_loading(pca) # 主成分分析の因子負荷量の検定
    biplot(pca)
}

#* 因子負荷量の分布
#* パスパラメータの値は、1から10の整数値を指定してください。
#* ```
#* > function(number) {
#* >     number <- as.numeric(number)
#* >     data(fasting) # テストデータ読み込み
#* >     pca <- prcomp(fasting$X, scale=TRUE) # 主成分分析
#* >     pca <- pca_loading(pca) # 主成分分析の因子負荷量の検定
#* >     mycol <- ifelse(sort(pca$loading$R[,number]) > 0, yes="green2", no="red2")
#* >     barplot(sort(pca$loading$R[,number]),
#* >         col=mycol,
#* >         main=paste0("Loading ", number, " (Correlation Coefficient)"))
#* > }
#* ```
#* @serializer png list(width=800, height=800)
#* @get /correlation-coefficien/<number:int>
function(number) {
    number <- as.integer(number)
    data(fasting) # テストデータ読み込み
    pca <- prcomp(fasting$X, scale=TRUE) # 主成分分析
    pca <- pca_loading(pca) # 主成分分析の因子負荷量の検定
    mycol <- ifelse(sort(pca$loading$R[,number]) > 0, yes="green2", no="red2")
    barplot(sort(pca$loading$R[,number]),
        col=mycol,
        main=paste0("Loading ", number, " (Correlation Coefficient)"))
}

#* p値の分布
#* パスパラメータの値は、1から10の整数値を指定してください。
#* ```
#* > function(number) {
#* >     number <- as.integer(number)
#* >     data(fasting) # テストデータ読み込み
#* >     pca <- prcomp(fasting$X, scale=TRUE) # 主成分分析
#* >     pca <- pca_loading(pca) # 主成分分析の因子負荷量の検定
#* >     barplot(sort(pca$loading$p.value[,number]),
#* >         main=paste0("Loading ", number, " (P-value)"))
#* > }
#* ```
#* @serializer png list(width=800, height=800)
#* @get /p-value/<number:int>
function(number) {
    number <- as.integer(number)
    data(fasting) # テストデータ読み込み
    pca <- prcomp(fasting$X, scale=TRUE) # 主成分分析
    pca <- pca_loading(pca) # 主成分分析の因子負荷量の検定
    barplot(sort(pca$loading$p.value[,number]),
        main=paste0("Loading ", number, " (P-value)"))
}
