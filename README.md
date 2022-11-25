#Author: Bin Wang (binwang@pku.edu.cn)

#Date: 2022-11-24

#The ExpoCros module was designed to analyze the cross-sectional data from exposome-wide association study (EWAS). This data structure can be obtained from the epidemiological designs of cross-section, case-control, and cohort. Please see the website (http://www.exposomex.cn/#/expoverse) for more information. Users can install the package using the following code:

if (!requireNamespace("devtools", quietly = TRUE)){
    install.packages("devtools")
}
  
devtools::install_github('ExposomeX/excros/excros',force = TRUE)
    
devtools::install_github('ExposomeX/extidy/extidy',force = TRUE) 
#"extidy" package is optional if the data file has been well prepared. However, the it is recommended as users may need tidy the data to meet the modeling requirement, such as deleting varaibles with low variance, transforming data type, classifying variable into several level, etc.
    
library(excros)
library(extidy) 

#OutPath = "D:/test" #The default path is the current working directory of R. Users can use this code to set the preferred path.

#For each step, the returned value can be named as users' like by following R language requirement. 

#All the PID must be the same with the one provided by InitCros function, e.g., res$PID.

res = InitCros()

res1 = LoadCros(PID=res$PID, UseExample="example#1") #note: res$PID is fixed for the following funtions
                
res2 = TransImput(PID=res$PID,
                  Group="T",
                  Vars="all.x",
                  Method="lod")
                  
res2$Expo$Data

res2$Expo$Voca

res3 = DelNearZeroVar(PID = res$PID)

res4 = DelMiss(PID = res$PID)

res5 = TransType(PID=res$PID,
                 Vars="Y2",
                 To="factor")
                 
res6 = TransClass(PID=res$PID,
                  Group="F",
                  Vars="X1",
                  LevelTo="4")
                  
res7 = TransScale(PID=res$PID,
                  Group="T",
                  Vars="all.x",
                  Method="normal")
                  
res8 = TransDistr(PID=res$PID,
                  Vars="C1,C2",
                  Method="log10")
                  
res10 = TransDummy(PID=res$PID,
                   Vars="default")

res10$Expo$Data 

res11 = FindCovaCros(PID=res$PID, 
                     VarsY = "Y1",
                     VarsC_Prior = "default",
                     VarsC_Fixed = NULL,
                     Method = "single.factor",
                     Thr = 0.1)
                     
res12 = CrosAsso(PID=res$PID,
                 EpiDesign = "cohort",
                 VarsY = "Y1",
                 VarsX = "X5,X6,X7,X8,X9,X10,X11", 
                 VarsN = "single.factor" ,
                 VarsSel = F,
                 VarsSelThr = 0.1,
                 IncCova = T,
                 Family = "gaussian",
                 RepMsr = F,
                 Corstr = "ar1")

res12_1 = CrosAsso(PID=res$PID,
                   EpiDesign = "cohort",
                   VarsY = "Y2",
                   VarsX = "X5,X6,X7,X8,X9,X10,X11", 
                   VarsN = "single.factor" ,
                   VarsSel = F,
                   VarsSelThr = 0.1,
                   IncCova = T,
                   Family = "binomial",
                   RepMsr = F,
                   Corstr = "ar1")

res13 = VizCrosAsso(PID=res$PID,
                    VarsN="single.factor",
                    Layout = "forest",
                    Brightness = "dark",
                    Palette = "default1")

res13$Y2_single.factor_forest_dark_default1 

res14 = CrosPred(PID=res$PID,
                 VarsY = "Y1",
                 VarsX = "X5,X6,X7,X8,X9,X10,X11",
                 PredType = "response",
                 VarsSel = F,
                 VarsSelThr = 0.1,
                 IncCova = F,
                 RsmpMethod = "cv" ,
                 Folds = 5 ,
                 Ratio = 0.667,
                 Repeats = 5)

res15 = VizCrosPred(PID=res$PID,
                    Layout = "bar",
                    Brightness = "light",
                    Palette = "science")

FuncExit(PID = res$PID) #Thanks for removing all the files from the back-end server. If not, we will remove it later.

