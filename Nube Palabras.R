#Source: https://towardsdatascience.com/create-a-word-cloud-with-r-bde3e7422e8a

#install.packages("wordcloud")
#install.packages("RColorBrewer")
#install.packages("wordcloud2")
#install.packages("tm")

library(dplyr)
library(wordcloud)
library(RColorBrewer)
library(wordcloud2)
library(tm)

#loading a text file from local computer
newdata <- readlines('/home/user/Desktop/Carta2019.txt')

filepath <- '/home/user/Desktop/Carta2019.txt'

fileName <- filepath
conn <- file(fileName,open="r")
linn <-readLines(conn)
for (i in 1:length(linn)){
  print(linn[i])
}
close(conn)


#Load data as corpus
#VectorSource() creates character vectors
mydata <- Corpus(VectorSource(linn))




text <- "Carta del presidente Estimadas amigas y amigos de Inditex:Cuando en marzo de 2020 me dirigía a todas las personas que integran nuestra empresa y a los medios de comunicación para expresar nuestra posición respecto a la pandemia de la covid-19, hacía una triple llamada a la solidaridad, a la confianza y a la serenidad. Solidaridad, en primer lugar, con todas las personas afectadas por esta pandemia. Serenidad para mantenernos firmes ante la que, seguramente, es la crisis más grave de la historia reciente por las implicaciones globales que conlleva. Pero, definitivamente, confianza en el futuro, por tener la seguridad de que es una situación que vamos a ser capaces de superar entre todos. Siento esta confianza especialmente reforzada al constatar la actitud de toda la plantilla de Inditex. Quiero expresar a todos y cada uno de ellos mi agradecimiento personal. Su altísima implicación durante la emergencia sanitaria ha sido eficaz y, sobre todo, emocionante por cuanto nos ha dado una vez más una lección de compromiso, compañerismo, solidaridad y entrega. Siempre hemos dicho que lo más importante para Inditex son las personas por encima de cualquier otra consideración, y las circunstancias que estamos viviendo actualmente lo demuestran.Esta Memoria tiene en cualquier caso la obligación de referirse al ejercicio 2019, por lo que haremos un esfuerzo especial de concentración. Y es que, aunque diluido por los  acontecimientos  del  2020,  el  ejercicio  de  2019  se  nos muestra como una referencia imprescindible de la fortaleza y consistencia de nuestro modelo de negocio. Los resultados lograron superar nuevas cotas históricas en todas las líneas, impulsando además nuestros objetivos sociales y medioambientales. Las ventas crecieron un 8% en un año caracterizado de forma notable por la extraordinaria buena recepción por parte de nuestros clientes de la creatividad de nuestros diseñadores. El beneficio neto creció un 12%, aunque finalmente quedó fijado en el 6% tras provisionar 287 millones de euros en los primeros momentos de la crisis, para anticiparnos al impacto de la covid-19. Las inversiones de 1.200 millones se dirigieron a reforzar la estrategia de implantación de nuestra plataforma integrada, presente ya en más de 200 mercados de todo el mundo. Y hemos contribuido fiscalmente en todo el mundo con impuestos por valor de 6.749 millones de euros, 1.874 de ellos en España, con una tasa efectiva del impuesto de sociedades del 22%. Especialmente destacable es la robusta posición financiera con la que cerramos el ejercicio 2019, de 8.060 millones de euros (+20%), que confirma plenamente que estamos en la estrategia correcta, corrobora la eficacia de la integración de inventarios y respalda la disciplina de la gestión. Seguimos firmes en nuestro objetivo de añadir valor social y medioambiental a nuestra actividad. Durante la última Junta General de Accionistas se aprobó la creación del Comité de Sostenibilidad dentro del Consejo de Administración y se anunciaron los nuevos objetivos del Grupo en esta materia. Entre ellos destaca la eliminación de los plásticos de un solo uso para el cliente en 2023; el reciclaje de todos los residuos en nuestros centros también para 2023; y la utilización del 100% de materias primas sostenibles, orgánicas o recicladas de viscosa en 2023 y de algodón, poliéster y lino en 2025.A lo largo del año 2020 todas las tiendas de la Compañía dispondrán de contenedores de recogida de prendas usadas, para su posterior reutilización o reciclaje en colaboración con 45 organizaciones sociales locales en los diferentes mercados, tales como Cáritas, Cruz Roja u Oxfam.Todas las marcas han llevado a cabo importantes acciones estratégicas vinculadas a esta política de sostenibilidad y las prendas distinguidas con la etiqueta Join Life supondrán ya un 25% del total a finales de 2020. Hemos impulsado también la investigación, destacando el proyecto coordinado por el MIT dotado con 3,5 millones de euros para promover, entre otros aspectos, la investigación en desafíos globales de sostenibilidad, incluyendo las técnicas de reciclaje upcycling.Esta voluntad de implicación social nos ha conducido ya en 2020 a poner toda nuestra capacidad logística al “Nuestra prioridad absoluta ante la covid-19 han sido las personasInditex · Memoria anual 20196102-14, 103-3
servicio de la empergencia sanitaria. Hemos establecido un corredor aéreo con China por el que al principio se logró enviar ayuda a aquel país, el primero en sufrir la epidemia, y que posteriormente sirvió para trasladar a Europa más de 120 millones de unidades de equipamiento sanitario en los momentos más difíciles de la crisis. Esta responsabilidad se concretó también muy especialmente en los compromisos con nuestros proveedores, a quienes no se ha cancelado ningún pedido, y para quienes hemos impulsado un acuerdo conjunto de la IOE, la OIT, IndustriALL, ITUC y decenas de grandes marcas  internacionales,  con  el  objetivo  de  apoyar  a  sus trabajadores, especialmente en los mercados con sistemas de protección social menos robustosNuestros compromisos se extienden a los 17 Objetivos de Desarrollo Sostenible (ODS) de Naciones Unidas, que son una guía imprescindible para asegurar el impacto positivo en nuestro entorno. Y lo decimos en un momento en el que es indispensable reivindicar el Pacto Mundial de Naciones Unidas, al que estamos adheridos, y los Principios Rectores sobre las Empresas y los Derechos Humanos, plenamente integrados en nuestro comportamiento como empresa.Este periodo, con la práctica totalidad de nuestras tiendas en el mundo -7.469 a cierre de ejercicio- cerradas durante semanas, nos ha permitido también identificar cómo algunas de las tendencias de compra que motivaron nuestro proyecto de plataforma integrada de tiendas y online se han acelerado.Por esta razón hemos decidido impulsar con más fuerza en los dos próximos años nuestro plan de plena integración entre el mundo físico y el mundo digital. Se reforzará la presencia online de las marcas y se concluirá la implantación del RFID en las cadenas. En línea con la estrategia de los últimos años, continuaremos profundizando en la apertura de tiendas más grandes y adaptadas tecnológicamente; se ampliarán y actualizarán tiendas existentes y se absorberán tiendas de menor tamaño y con menos capacidad de prestar estos nuevos servicios integrados al cliente.Esta estrategia está transformando el perfil de la Compañía y la dejará preparada para las oportunidades que se van a presentar, convirtiéndonos en una Compañía plenamente integrada, plenamente sostenible y plenamente digital. Muchas gracias."

text <- "Cuandoenmarzode2020medirigíaatodaslaspersonasqueintegrannuestraempresayalosmediosdecomunicaciónparaexpresarnuestraposiciónrespectoalapandemiadelacovid-19,hacíaunatriplellamadaalasolidaridad,alaconfianzayalaserenidad.Solidaridad,enprimerlugar,contodaslaspersonasafectadas por esta pandemia. Serenidad para mantenernos firmesantelaque,seguramente,eslacrisismásgravedelahistoriarecienteporlasimplicacionesglobalesqueconlleva.Pero,definitivamente,confianzaenelfuturo,portenerlaseguridaddequeesunasituaciónquevamosasercapacesdesuperarentretodos.SientoestaconfianzaespecialmentereforzadaalconstatarlaactituddetodalaplantilladeInditex.Quieroexpresaratodosycadaunodeellosmiagradecimientopersonal.Sualtísimaimplicacióndurantelaemergenciasanitariahasidoeficazy,sobretodo,emocionanteporcuantonoshadadounavezmásunaleccióndecompromiso,compañerismo"

#my_corpus <- VCorpus(VectorSource("/home/user/Desktop/Carta2019.txt"))
#docs <- Corpus(VectorSource("/home/user/Desktop/Carta2019.txt"))
docs <- Corpus(VectorSource(text))


docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("spanish"))


dtm <- TermDocumentMatrix(docs)
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

# Visualizacion 1
set.seed(1234) # for reproducibility 
wordcloud(words = df$word, freq = df$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35,
          colors=brewer.pal(8, "Dark2"))

#Visualizacion 2
wordcloud2(data=df, size=1.6, color='random-dark')

