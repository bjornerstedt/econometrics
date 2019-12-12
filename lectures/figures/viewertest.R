tempDir <- tempfile()
dir.create(tempDir)
htmlFile <- file.path( "index.html")
htmlFile2 <- file.path(tempDir, "index.html")
file.copy(htmlFile , htmlFile2)
rstudio::viewer(htmlFile)

# put static files in C:\R\R-3.1.3\doc\manual

library(package)