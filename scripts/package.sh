#!/bin/bash
echo "
<html>
<style>
.pass{background-color:lightgreen}
.fail{background-color:lightgrey}
table, th, td {
   border: 1px solid black;
   text-align:center;
}
.md5, .diff{
    font-size:10px;
}
</style>
<body>
<h1>Test Results</h1>
<div><a href='https://github.com/dissolve/mf2-tester'>Source</a></div>
<br><br><br>
<table>" > results/index.html
TEST_SUITE_VERSION=`bash scripts/tests-version.sh`;

echo "<tr>
<th>Test</th>
<th>Test Suite <div class='version'>$TEST_SUITE_VERSION</div></th>" >> results/index.html

for lang in `ls languages`; do 
    NAME=`cat languages/${lang}/label`
    VERSION=`bash languages/${lang}/version.sh`
    echo "<th>$NAME <div class='version'>$VERSION</div></th>" >> results/index.html
done

echo "</tr>" >> results/index.html

TOTAL=0
for lang in `ls languages`; do 
    declare "count_$lang=0"
done

for f in results/test-results/*/*/*.json ; 
    do 
        RESULT=`echo $f |sed 's/results\///'`;
        TEST=`echo $RESULT |sed 's/test-results/tests/'|sed 's/.json/.txt/'`;
        

        NAME=`echo $TEST |sed 's/tests\///'|sed s/.txt//|sed 's/\//<br>/g'`;

        echo '<tr>' >> results/table.html;
        echo '<td><a href="'$TEST'">'$NAME'</a></td>' >> results/table.html;

        RESULT_MD5=`md5sum results/$RESULT |cut -d ' ' -f 1`;
        SHORT_MD5=`echo $RESULT_MD5 |cut -c 1-10`
        CLASS="pass";
        echo "<td class='$CLASS'>Test Suite: <a href='$RESULT'>View</a><br><span class='md5' title='$RESULT_MD5'>$SHORT_MD5...</span></td>" >> results/table.html;
        TOTAL=$[$TOTAL + 1]

        for lang in `ls languages`; do 

            lang_RESULT=`echo $RESULT |sed s/test-results/$lang/`;
            lang_RESULT_MD5=`md5sum results/$lang_RESULT |cut -d ' ' -f 1`;
            lang_SHORT_MD5=`echo $lang_RESULT_MD5 |cut -c 1-10`
            if [ "$RESULT_MD5" = "$lang_RESULT_MD5" ]; then
                echo "<td class='pass'>Result: <a href='$lang_RESULT'>View</a> <br><span class='md5' title='$lang_RESULT_MD5'>$lang_SHORT_MD5...</span></td>" >> results/table.html;
                lang_total="count_$lang"
                declare "count_$lang=$[${!lang_total} + 1]"
            else
                diff results/$RESULT results/$lang_RESULT > results/$lang_RESULT.diff.txt
                echo "<td class='fail'>Result: <a href='$lang_RESULT'>View</a> <br><span class='md5' title='$lang_RESULT_MD5'>$lang_SHORT_MD5...</span>
                <div class='diff'><a href='$lang_RESULT.diff.txt'>Diff</a></div>
                </td>" >> results/table.html;
            fi
        done



        echo '</tr>' >> results/table.html;

done;

echo "
<tr>
<td></td>
<td></td> " >> results/index.html


for lang in `ls languages`; do 
    lang_total="count_$lang"
    echo "<td>${!lang_total} of $TOTAL passed</td> " >> results/index.html
done

echo "</tr>" >> results/index.html

cat results/table.html >> results/index.html

echo "</table>
</body>
</html>" >> results/index.html
