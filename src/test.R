library("loadings") # ロード

data(fasting) # テストデータ読み込み
pca <- prcomp(fasting$X, scale=TRUE) # 主成分分析
pca <- pca_loading(pca) # 主成分分析の因子負荷量の検定

current_path <- getwd()
setwd(paste(current_path, "/data", sep=""))
paste("png file output path: ", getwd(), sep="")

png("test.png", width=800, height=800)
biplot(pca)
dev.off()
