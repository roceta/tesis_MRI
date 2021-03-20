#Imports

  library(tidyverse)
  library(ggplot2)


#Archivos

  archivo_datos_inditex <- 'datos_inditex.csv'


#---- 1. Leo los datos ----

  datos_inditex <- read.csv(archivo_datos_inditex,sep=";", dec=",")
  
  remove(archivo_datos_inditex)
  
  
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
    

  #3.2 Beneficio neto total (en Miles de millones)
  datos_beneficio_neto_total <- select(datos_inditex %>% 
    filter( 
      ejercicio %in% c(1996:2019) & 
        indicador == 'bn'
    ),
      'ejercicio',
      'valor'
  )
  
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
  datos_superficie <- select(datos_inditex %>% 
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
  

#---- 4. Gráficos ----
  

  #numero del histograma a graficar
  histograma <- 4
  
  #años clave a graficar
  ejercicios_clave <- c(2006,2008,2015)
  

  
  histogramas = list(
    datos_ventas_totales,         #1
    datos_beneficio_neto_total,   #2
    datos_ventas_por_region,      #3
    datos_tiendas,                #4
    datos_mercados_que_opera,     #5
    datos_prendas_en_mercado      #6
  )

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

    geom_area(fill="#e1331d") +
    geom_point(data=puntos_clave,size = 5,alpha=1,fill='black') +
    geom_line() +

    theme_classic() + 

    xlab("Ejercicio") + 
    ylab("Valor")
  
  #theme(plot.title = element_text(hjust = 0.5)) +
  #ggtitle("Titulo") +  
  
  
  
  datos_ventas_por_region['valor'] <- datos_ventas_por_region['valor']*100
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

