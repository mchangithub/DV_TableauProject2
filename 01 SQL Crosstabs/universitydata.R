universitydf <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query="select * from UNIVERSITYDATA "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_mc44693', PASS='orcl_mc44693', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
options(dplyr.width = Inf)
rankdf <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select STATE, EnrollTotals,rank() over(order by EnrollTotals desc) as Rank from
(
select STATE, sum(FULLTIMEENTERING2013) as EnrollTotals
from UNIVERSITYDATA
group by STATE
)"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_mc44693', PASS='orcl_mc44693', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(rankdf)

maxdiffdf <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"select STATE, SYSTEMNAME, NAME, ENTERINGCLASS2013, last_value(max_enteringclass) 
OVER (PARTITION BY SYSTEMNAME order by ENTERINGCLASS2013 desc) max_enteringclass, last_value(max_enteringclass) 
OVER (PARTITION BY SYSTEMNAME order by ENTERINGCLASS2013 desc) - ENTERINGCLASS2013 enteringclass_diff
from
(SELECT STATE, SYSTEMNAME, NAME, ENTERINGCLASS2013, max(ENTERINGCLASS2013)
OVER (PARTITION BY SYSTEMNAME) max_enteringclass 
FROM UNIVERSITYDATA)
where SYSTEMNAME <> \\\' \\\' and ENTERINGCLASS2013 is not null and ENTERINGCLASS2013>0 and STATE = \\\'TX\\\'
order by 2,4 desc"
')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_mc44693', PASS='orcl_mc44693', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)));
tbl_df(maxdiffdf)

nthdf <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT state, city, name, fulltimeentering2013, nth_value(fulltimeentering2013,1)
OVER (PARTITION BY state ORDER BY fulltimeentering2013 desc) max_entering
FROM universitydata
WHERE fulltimeentering2013 <> 0
ORDER BY 1,2,3"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_mc44693', PASS='orcl_mc44693', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
tbl_df(nthdf)

cumedistdf <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", '129.152.144.84:5001/rest/native/?query=
"SELECT state, city, name, fulltimeentering2013, cume_dist()
OVER (PARTITION BY state ORDER BY fulltimeentering2013) cume_dist
FROM universitydata
WHERE fulltimeentering2013 <> 0
ORDER BY 1,2,3"')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_mc44693', PASS='orcl_mc44693', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
tbl_df(cumedistdf)
