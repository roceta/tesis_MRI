#Imports

  library(tidyverse)
  library(ggplot2)
  library(treemap)

#Archivos

  archivo_datos_inditex <- './data/datos_inditex.csv'
  archivo_datos_superficies <- './data/superficies.csv'
  archivo_datos_balanza_comercial <- './data/balanza_comercial.csv'
  

#---- 1. Leo los datos ----

  datos_inditex <- read.csv(archivo_datos_inditex,sep=";", dec=",")
  datos_superficies <- read.csv(archivo_datos_superficies,sep=";", dec=",")
  datos_balanza_comercial <- read.csv(archivo_datos_balanza_comercial,sep=";", dec=",")
  
  remove(archivo_datos_inditex)
  remove(archivo_datos_superficies)
  remove(archivo_datos_balanza_comercial)
  
#---- 2. Limpio los datos ----
  
  #Cambio nombre de las columnas
  datos_inditex <- rename(datos_inditex, 
                      'indicador' = 'Ind',
                      'valor' = 'Cantidad.Total',
                      'ejercicio' = 'Ejercicio'
                          )
  
  #Me quedo con las columnas interesantes
  datos_inditex <- select(datos_inditex,
                          'ejercicio',
                          'indicador',
                          'valor',
                          )  

  #Transformo los valores en números
  datos_inditex <- transform(datos_inditex, valor = as.numeric(valor))
  

#---- 3. Preparo los datos para los gráficos ----

  #3.1 Ventas totales
  datos_ventas_totales <- select(datos_inditex %>% 
    filter( 
      ejercicio %in% c(1996:2019) & 
      indicador == 'vtn'
      ),
      'ejercicio',
      'valor'
  )
  datos_ventas_totales['valor'] <- datos_ventas_totales['valor'] / 1000
    

  #3.2 Beneficio neto total (en Miles de millones)
  datos_beneficio_neto_total <- select(datos_inditex %>% 
    filter( 
      ejercicio %in% c(1996:2019) & 
        indicador == 'bn'
    ),
      'ejercicio',
      'valor'
  )
  datos_beneficio_neto_total['valor'] <- datos_beneficio_neto_total['valor'] / 100
  
  #3.3 Ventas por region
  datos_ventas_por_region <- select(datos_inditex %>% 
    filter( 
      ejercicio %in% c(1996:2019) & 
        indicador %in% c('vEsp','vUE','vAm','vAsm') &
        valor != ''
    ),
      'ejercicio',
      'indicador',
      'valor'
  )
  #paso a porcentaje
  datos_ventas_por_region['valor'] <- datos_ventas_por_region['valor'] * 100
  
  
  #3.4 Superficie
  datos_superficie_inditex <- select(datos_inditex %>% 
    filter( 
      ejercicio %in% c(1994:2018) & 
        indicador == 'vsup'
    ),
      'ejercicio',
      'valor'
  )  

  #3.5 Cantidad de empleados
  datos_empleados <- select(datos_inditex %>% 
    filter( 
      ejercicio %in% c(1996:2019) & 
        indicador == 'e'
    ),
      'ejercicio',
      'valor'
  )  
  
  #3.6 Cantidad de tiendas
  datos_tiendas <- select(datos_inditex %>% 
    filter( 
      ejercicio %in% c(1996:2019) & 
        indicador == 't'
    ),
      'ejercicio',
      'valor'
  )  
  l
  #3.7 Mercados en los que opera
  datos_mercados_que_opera <- select(datos_inditex %>% 
    filter( 
      ejercicio %in% c(1996:2018) & 
        indicador == 'mo'
    ),
      'ejercicio',
      'valor'
  )  
  
  #3.8 Prendas puestas en el mercado ()
  datos_prendas_en_mercado <- select(datos_inditex %>% 
    filter( 
      ejercicio %in% c(2001:2018) & 
        indicador == 'pr'
    ),
      'ejercicio',
      'valor'
  )    
  datos_prendas_en_mercado['valor'] <- round(datos_prendas_en_mercado['valor'] /1000000,digits = 0)
  
  #3.9 Balanza comercial
    regiones_de_interes <- c("España", 
                              "Cataluña", 
                              "Madrid",
                              "Galicia",
                              "Comunidad Valenciana", 
                              "Andalucia")
    #Paso a miles de millones de euros
    datos_balanza_comercial["Cantidad"] <- datos_balanza_comercial["Cantidad"] /1000
    
    #me quedo con las regiones interesantes
    datos_balanza_comercial <- datos_balanza_comercial %>%
                                  filter(Region %in% regiones_de_interes) %>%
                                  filter(Indicador %in% c("Exportaciones", "Importaciones"))
    
    #para reordenar los paneles del facet_wrap()
    datos_balanza_comercial$Region <- factor(datos_balanza_comercial$Region,      
                                             levels = regiones_de_interes)
    
  

#---- 4. Gráficos ----

  histogramas = list(
    datos_balanza_comercial,      #1
    datos_ventas_totales,         #2
    datos_beneficio_neto_total,   #3
    datos_prendas_en_mercado,     #4
    datos_tiendas,                #5
    datos_mercados_que_opera,     #6
    datos_ventas_por_region       #7
  )
  
  colores <- c("#e8563f","#3982d1","#49a28e","#f7e26b","#f092a3","#a3aed7","#0c276e")
    
  
  #-- 4.1 Balanza comercial --
  
  histograma <- 1
  
  as.data.frame(histogramas[histograma]) %>%
    ggplot(aes(x = Año, y = Cantidad, colour = Indicador)) +
    geom_line(size = 1L) +
    scale_color_hue() +
    theme_minimal() +
    labs(colour="")+
    ylab("Miles de millones de euros") +  
    facet_wrap(vars(Region))
  
  ggsave(paste("./graficos/grafico",histograma,".png",sep=""))
  
  
  #-- 4.2 Grafico de ventas totales --

  #numero del histograma a graficar
  histograma <- 2
  
  #años clave a graficar
  ejercicios_clave <- c(2015)


  #creo el dataframe con los valores de los ejercicios clave
  puntos_clave <- as.data.frame(histogramas[histograma]) %>%
                    filter(
                        ejercicio %in% ejercicios_clave
                    )
  
  #armo y presento el gráfico
  as.data.frame(histogramas[histograma]) %>%
    ggplot(aes(
            x = ejercicio,
            y = valor
            )
        ) + 

    #geom_area(fill="#e1331d") + (color inditex)
    geom_area(fill=colores[histograma]) +
    geom_point(data=puntos_clave,size = 1,alpha=1,fill='black') +
    geom_text(data=puntos_clave,aes(label=valor),hjust=0.5, vjust=-1)+

    xlab("Año") + 
    ylab("Miles de millones de euros") + 
    ylim(0L, 30L)+
    
    theme_minimal()
  
  ggsave(paste("./graficos/grafico",histograma,".png",sep=""))
    
  

  #-- 4.3 Grafico de beneficios netos --
  
    #numero del histograma a graficar
    histograma <- 3
    
    #años clave a graficar
    ejercicios_clave <- c(2015)
    
    #creo el dataframe con los valores de los ejercicios clave
    puntos_clave <- as.data.frame(histogramas[histograma]) %>%
      filter(
        ejercicio %in% ejercicios_clave
      )
    
    #armo y presento el gráfico
    as.data.frame(histogramas[histograma]) %>%
      ggplot(aes(
        x = ejercicio,
        y = valor
      )
      ) + 
      
      geom_area(fill=colores[histograma]) +
      geom_point(data=puntos_clave,size = 1,alpha=1,fill='black') +
      geom_text(data=puntos_clave,aes(label=valor),hjust=0.5, vjust=-1)+
      
      xlab("Año") + 
      ylab("Miles de millones de euros") + 
      
      
      theme_minimal()
    
    ggsave(paste("./graficos/grafico",histograma,".png",sep=""))
  
  
  #-- 4.4 Grafico Cantidad de prendas en el mercado --
    
    #numero del histograma a graficar
    histograma <- 4
    
    #años clave a graficar
    ejercicios_clave <- c(2005,2015)
    
    #creo el dataframe con los valores de los ejercicios clave
    puntos_clave <- as.data.frame(histogramas[histograma]) %>%
      filter(
        ejercicio %in% ejercicios_clave
      )
    
    #armo y presento el gráfico
    as.data.frame(histogramas[histograma]) %>%
      ggplot(aes(
        x = ejercicio,
        y = valor
      )
      ) + 
      
      geom_area(fill=colores[histograma]) +
      geom_point(data=puntos_clave,size = 1,alpha=1,fill='black') +
      geom_text(data=puntos_clave,aes(label=valor),hjust=0.5, vjust=-1)+
      
      xlab("Año") + 
      ylab("Millones de prendas") + 
      # ylim(0L, 30L)+
      
      theme_minimal()
    
    ggsave(paste("./graficos/grafico",histograma,".png",sep=""))
    
    
  #-- 4.5 Grafico Cantidad de tiendas --
    
    #numero del histograma a graficar
    histograma <- 5
    
    #años clave a graficar
    ejercicios_clave <- c(2005,2015)
    
    #creo el dataframe con los valores de los ejercicios clave
    puntos_clave <- as.data.frame(histogramas[histograma]) %>%
      filter(
        ejercicio %in% ejercicios_clave
      )
    
    #armo y presento el gráfico
    as.data.frame(histogramas[histograma]) %>%
      ggplot(aes(
        x = ejercicio,
        y = valor
      )
      ) + 
      
      geom_area(fill=colores[histograma]) +
      geom_point(data=puntos_clave,size = 1,alpha=1,fill='black') +
      geom_text(data=puntos_clave,aes(label=valor),hjust=0.5, vjust=-1)+
      
      xlab("Año") + 
      ylab("Cantidad de tiendas") + 
      # ylim(0L, 30L)+
      
      theme_minimal()
    
    ggsave(paste("./graficos/grafico",histograma,".png",sep=""))
    
    
  #-- 4.6 Grafico Cantidad de mercados --
    
    #numero del histograma a graficar
    histograma <- 6
    
    #años clave a graficar
    ejercicios_clave <- c(2005,2015)
    
    #creo el dataframe con los valores de los ejercicios clave
    puntos_clave <- as.data.frame(histogramas[histograma]) %>%
      filter(
        ejercicio %in% ejercicios_clave
      )
    
    #armo y presento el gráfico
    as.data.frame(histogramas[histograma]) %>%
      ggplot(aes(
        x = ejercicio,
        y = valor
      )
      ) + 
      
      geom_area(fill=colores[histograma]) +
      geom_point(data=puntos_clave,size = 1,alpha=1,fill='black') +
      geom_text(data=puntos_clave,aes(label=valor),hjust=0.5, vjust=-1)+
      
      xlab("Año") + 
      ylab("Cantidad de mercados") + 
      # ylim(0L, 30L)+
      
      theme_minimal()
    
    ggsave(paste("./graficos/grafico",histograma,".png",sep=""))
    
    
  #-- 4.7 Grafico ventas por region --
    
    #numero del histograma a graficar
    histograma <- 7
    
    #armo y presento el gráfico
    as.data.frame(histogramas[histograma]) %>%
      ggplot(aes(
        x = ejercicio,
        y = valor,
        colour = indicador
      )
      ) + 
      
      geom_line(size = 1.2) +
      scale_color_hue(
        name = "", 
        labels = c("América", "Asia y otros", "España", "UE"))+
      
      
      xlab("Año") + 
      ylab("% de ventas por región") + 
      
      theme_minimal()
    
    ggsave(paste("./graficos/grafico",histograma,".png",sep=""))
    
  
  
  
  
  

