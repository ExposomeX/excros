% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expocros.R
\name{CrosPred}
\alias{CrosPred}
\title{Build prediction models}
\usage{
CrosPred = function(PID,OutPath = "default",VarsY,VarsX = "all.x",
    PredType = "response",VarsSel = "F",VarsSelThr = 0.1,IncCova = T,
    RsmpMethod = "cv",Folds = 5,Ratio = 0.667,Repeats = 5)
}
\arguments{
\item{PID}{chr. Program ID. It must be the same with the PID generated by ExpoCros}

\item{OutPath}{chr. Output file directory, e.g. "D:/test". It should be noted that the slash symbol is "/", not "\".
If "default", the current working directory will be set.}

\item{VarsY}{chr. Outcome variable used for modeling. Only one variable can be entered.}

\item{VarsX}{chr. Exposure variable used for modeling. The default option is
"all.x" (All exposure variables are included). Users can also choose available variables.
It should be noted that there is fixed format for the entering characters
separated with comma and without space, e.g., "X1,X2,X3"}

\item{PredType}{chr. Prediction type of the outcome variable, including "response"
for the actual values and "prob" for outcome with binary variable.}

\item{VarsSel}{lgl. Whether to select the significant variable for the final model.
Available options include T (or TRUE) and F (or FALSE).}

\item{VarsSelThr}{num. If "VarsSel" = T, provide the selection threshold of
the P-value. Three value can be chosen, i.e. 0.05, 0.1, and 0.2.}

\item{IncCova}{lgl. Whether to include the covariate selected in the function of "FindCovaCros".
Available options include T (or TRUE) and F (or FALSE).}

\item{RsmpMethod}{chr. Four resampling methods options for internal validation, including
"cv" (i.e.,Cross validation) , "loo" (i.e., eave-one-out), "bootstrap", and "holdout".}

\item{Folds}{num. Folds of Cross-validation resampling. It is ranging 2-10.}

\item{Ratio}{num. Ratio of Bootstrap resampling. It is ranging 0.4-0.9.}

\item{Repeats}{num. Number of Bootstrap resampling. It is ranging 2-20.}
}
\value{
A list containing the prediction performance evaluation.
}
\description{
Build prediction models
}
\examples{
res <- InitCros()
   res1 = LoadCros(PID = res$PID, UseExample = "example#1")
   res2 = TransScale(PID=res$PID, Group="T", Vars="all.x", Method="normal")
   res3 = CrosPred(PID=res$PID, VarsY = "Y1", VarsX = "X5,X6,X7,X8,X9,X10,X11",
   PredType = "response",VarsSel = F,VarsSelThr = 0.1,IncCova = F,
   RsmpMethod = "cv" ,Folds = 5,Ratio = 0.667,Repeats = 5)
   FuncExit(PID = res$PID)
}
\author{
Bin Wang
}
