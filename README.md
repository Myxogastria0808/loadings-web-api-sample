---
title: Loadings Web API Sample
emoji: 🚀
colorFrom: gray
colorTo: indigo
sdk: docker
pinned: false
license: mit
---

# Loading Web API Sample

## Setup

Nix を使用して環境の構築

> [!WARNING]
> Nix がインストールされている必要があります。

```
nix-shell
```

Web API の起動

```
cd src
Rscript pr.R
```

## API のエンドポイント

Local: http://127.0.0.1:7860/pca

Hugging Face Spaces: https://myxogastria0808-loadings-web-api-sample.hf.space/pca

````r
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
````

Local: http://127.0.0.1:7860/correlation-coefficien/{number}

Hugging Face Spaces: https://myxogastria0808-loadings-web-api-sample.hf.space/correlation-coefficien/{number}

````r
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
````

Local: http://127.0.0.1:7860/p-value/{number}

Hugging Face Spaces: https://myxogastria0808-loadings-web-api-sample.hf.space/p-value/{number}

````r
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
````

Local: http://127.0.0.1:7860/__docs__/#/

Hugging Face Spaces: https://myxogastria0808-loadings-web-api-sample.hf.space/__docs__/#/

以下は、Swagger UI の画面の様子です。

![Swagger UI](https://github.com/user-attachments/assets/1eab9119-daf5-43fc-9418-3dacc7bded11)

## 参考サイト

https://www.rplumber.io/articles/rendering-output.html
