#-- 4.8 Grafico comparativo superficies --


colores_treemap <- c("#0CB7F2",
                     "#53d4ff",
                     "#8fe3ff",
                     "#bceeff",
                     "#e1331d", #INDITEX
                     "#def7ff",
                     "#4ed2ad",
                     "#73d9bc",
                     "#9befd7",
                     "#cffff1",
                     "#edfffa")

#añado la superficie de inditex
datos_superficies <- datos_superficies %>% 
                        add_row(
                                Ciudad = "Inditex", 
                                Superficie = round(max(datos_superficie_inditex)/1000,digits=0)
                                )

#añado las etiquetas
datos_superficies["Descripcion"] <- c(paste(datos_superficies$Ciudad,"-",datos_superficies$Superficie,"(km2)"))

#grafico
treemap(datos_superficies,
        index=c("Descripcion"),
        vSize="Superficie",
        palette = colores_treemap,
        type="index",
        title = "",
        align.labels=list(
          c("center", "center")
        ) 
        )



