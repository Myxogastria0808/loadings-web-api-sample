library("loadings") # ロード

data(fasting) # テストデータ読み込み
pca <- prcomp(fasting$X, scale=TRUE) # 主成分分析
pca <- pca_loading(pca) # 主成分分析の因子負荷量の検定

current_path <- getwd()
setwd(paste(current_path, "/data", sep=""))
paste("png files output path: ", getwd(), sep="")

# 因子負荷量の分布
layout(cbind(1:5, 6:10))
for(i in seq(10)){
    mycol <- ifelse(sort(pca$loading$R[,i]) > 0, yes="green2", no="red2")
    png(paste("test2-Correlation-Coefficien-", i, ".png", sep=""), width=800, height=800)
    barplot(sort(pca$loading$R[,i]),
        col=mycol,
        main=paste0("Loading ", i, " (Correlation Coefficient)"))
    dev.off()
}

# p値の分布
layout(cbind(1:5, 6:10))
for(i in seq(10)){
    png(paste("test2-P-value-", i, ".png", sep=""), width=800, height=800)
    barplot(sort(pca$loading$p.value[,i]),
        main=paste0("Loading ", i, " (P-value)"))
    dev.off()
}
