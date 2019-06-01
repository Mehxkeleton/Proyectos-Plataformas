-----Detección de Emociones / Deep Learning-----

Haciendo una pequeña introducción al programa, se trata de realizar un análisis en tiempo real acerca de los
sentimientos que una persona puede presentar.
Para lograrlo primero es necesario pasar las imágenes que demuestran el sentimiento en una red neuronal tipo back-propagation
para identificar patrones.
dentro de la carpeta haarcascades encontramos: 

-Una carpeta llamada "data" el cual contiene 2 carpetas, una llamada test y la otra train, ambas contienen 7 carpetas con 
imágenes de distintas expresiones faciales con filtro blanco y negro, ya que asi es mas fácil para el reconocimiento de facciones.
La carpeta train se utiliza primero para reconocer las facciones, después la red utiliza las imágenes de train para comparar resultados
y saber el error que tiene al aprender. Nosotros dejamos que el programa pasara por 50 épocas para una mejor aprendizaje.

- Archivo principal con el código llamado "camera.py"

- 3 archivos pre-entrenados, los .xml los cuales contienen descripciones genéricas de objetos, en este caso se encargan de detectar
la cara, y los ojos. El archivo .h5 es el producto del análisis de la red después de haber entrenado.
-imágenes .jpg que utilizamos para probar los resultados del análisis de la red, actualmente ya no se encuentran dentro del codigo,
ya que cambiamos el reconocimiento de fotos a cámara en tiempo real.

-----Pre-requisitos-----

Necesitamos instalar Anaconda con la versión Python 3.7 y sus librerías necesarias para el funcionamiento, tales como
Keras
numpy (incluida en anaconda)
tensorflow
tflearn

Es necesario también que la PC tenga su propia cámara de video de una calidad buena, ya que mientras mayor calidad tendremos 
mejores resultados.



-----Instalación-----

Podemos encontrar anaconda 3.7 en la pagina https://www.anaconda.com/distribution/
Las demás librerías se instalan dentro de la consola anaconda powershell con el comando
	
	 pip install "name" 

-----Ejecutando Pruebas-----

Para poder ejecutar las pruebas debemos movernos a la carpeta donde se encuentra el archivo "camera.py"
a travez del cmd, en mi caso la dirección es C:\opencv\data\haarcascades
Para ejecutar el programa en modo entrenamiento utilizaremos el comando 

	python camera.py --mode train

Esto es para que el programa ejecute la red neuronal y comience a hacer el reconocimiento de patrones.
(el proceso tarde horas)
Después ejecutamos el comando para comparar los resultados obtenido con una transmisión de video en tiempo real.

	python kerasmodel.py --mode display

Una vez ejecutado este comando se abrirala camara de la PC mostrando un cuadro en la cara del usuario que dice el sentimiento 
presentado.
