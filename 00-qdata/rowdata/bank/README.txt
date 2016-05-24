- questo README è stato creato il 2016-02-15 da Enrico Tonini
- l'ultimo aggiornamento è stato fatto il 2016-02-23

Riporto il processo che ha portato ai file .RData del package a partire dai file .csv di questa cartella:

1) ho scaricato bank.zip da http://archive.ics.uci.edu/ml/machine-learning-databases/00222/;
2) ho estratto lo zip e, dopo averlo estratto, ho tenuto solo il file completo ("bank-full.csv") rinominandolo in "bank-original.csv", oltre a "bank-names.csv" che contiene la descrizione dei dati;
3) a "bank-original.csv" ho aggiunto "a mano" in Libre Office l'anno e l'id e ho rinominato il file così ottenuto in "bank-modified.csv";
4) ho importato in R "bank-modified.csv" e a partire da questo, tramite ulteriori manipolazioni scritte ed eseguite nel codice "../../r/modify-bank-data.R", ho creato i tre file in formato .RData e li ho salvati nella cartella data del package ("../../r/qData/data"), pronti per essere utilizzati per il corso.

Il file intero da utilizzare per gli esempi dei corsi è "bank.RData", che è ordinato per id (e per data).
"bank1.RData" contiene la prima metà delle variabili di "bank.RData", "bank2.RData" la seconda metà e nessuno dei due è ordinato per id, ma sono ordinati casualmente. Entrambi contengono la variabile "id", grazie a cui è possibile riunire bank1 e bank2 per ottenere un data frame identico a bank.


