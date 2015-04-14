universitydf <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select * from UNIVERSITYDATA "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_mc44693', PASS='orcl_mc44693', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

nthdf <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT state, city, name, fulltimeentering2013, nth_value(fulltimeentering2013,1)
OVER (PARTITION BY state ORDER BY fulltimeentering2013 desc) max_entering
FROM universitydata
WHERE fulltimeentering2013 <> 0
ORDER BY 1,2,3"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_mc44693', PASS='orcl_mc44693', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
head(nthdf)

cumedistdf <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT state, city, name, fulltimeentering2013, cume_dist()
OVER (PARTITION BY state ORDER BY fulltimeentering2013) cume_dist
FROM universitydata
WHERE fulltimeentering2013 <> 0
ORDER BY 1,2,3"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_mc44693', PASS='orcl_mc44693', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
head(cumedistdf)
