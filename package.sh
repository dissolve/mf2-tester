#!/bin/bash
rm -rf dist
mkdir dist
cp -r ruby python php tests test-results dist/

echo "
<html>
<style>
.pass{background-color:lightgreen}
.fail{background-color:lightgrey}
table, th, td {
   border: 1px solid black;
   text-align:center;
}
.md5{
font-size:10px;
}
</style>
<body>
<h1>Test Results</h1>
<br><br><br>
<table>" > dist/index.html
echo "<tr><th>Test</th><th>Test Suite</th><th>PHP</th><th>Python</th><th>Ruby</th></tr>" >> dist/index.html
for f in vendor/mf2/tests/tests/microformats-*/*/*.json ; 
    do 
        RESULT=`echo $f |sed s/vendor.mf2.tests.tests/test-results/`;
        TEST=`echo $RESULT |sed s/test-results/tests/|sed s/json/txt/`;

        PHP_RESULT=`echo $RESULT |sed s/test-results/php/`;
        PYTHON_RESULT=`echo $RESULT |sed s/test-results/python/`;
        RUBY_RESULT=`echo $RESULT |sed s/test-results/ruby/`;

        NAME=`echo $TEST |sed s/tests//|sed s/.txt//|sed 's/\//<br>/g'`;

        echo '<tr>' >> dist/index.html;
        echo '<td><a href="'$TEST'">'$NAME'</a></td>' >> dist/index.html;

        RESULT_MD5=`md5sum $RESULT |cut -d ' ' -f 1`;
        CLASS="pass";
        #echo '<td class="'$CLASS'"><a href="'$RESULT'">'$RESULT_MD5'</a></td>' >> dist/index.html;
        echo '<td class="'$CLASS'">Test Suite: <a href="'$RESULT'">View</a><br><span class="md5">'$RESULT_MD5'</span></td>' >> dist/index.html;

        PHP_RESULT_MD5=`md5sum $PHP_RESULT |cut -d ' ' -f 1`;

        CLASS="fail";
        if [ "$RESULT_MD5" = "$PHP_RESULT_MD5" ]; then
            CLASS="pass";
        fi
        #echo '<td class="'$CLASS'"><a href="'$PHP_RESULT'">'$PHP_RESULT_MD5'</a></td>' >> dist/index.html;
        echo '<td class="'$CLASS'">Result: <a href="'$PHP_RESULT'">View</a> <br><span class="md5">'$PHP_RESULT_MD5'</span></td>' >> dist/index.html;

        PYTHON_RESULT_MD5=`md5sum $PYTHON_RESULT |cut -d ' ' -f 1`;
        CLASS="fail";
        if [ "$RESULT_MD5" = "$PYTHON_RESULT_MD5" ]; then
            CLASS="pass";
        fi
        #echo '<td class="'$CLASS'"><a href="'$PYTHON_RESULT'">'$PYTHON_RESULT_MD5'</a></td>' >> dist/index.html;
        echo '<td class="'$CLASS'">Result: <a href="'$PYTHON_RESULT'">View</a><br><span class="md5">'$PYTHON_RESULT_MD5'</span></td>' >> dist/index.html;

        RUBY_RESULT_MD5=`md5sum $RUBY_RESULT |cut -d ' ' -f 1`;
        CLASS="fail";
        if [ "$RESULT_MD5" = "$RUBY_RESULT_MD5" ]; then
            CLASS="pass";
        fi
        #echo '<td class="'$CLASS'"><a href="'$RUBY_RESULT'">'$RUBY_RESULT_MD5'</a></td>' >> dist/index.html;
        echo '<td class="'$CLASS'">Result: <a href="'$RUBY_RESULT'">View</a><br><span class="md5">'$RUBY_RESULT_MD5'</span></td>' >> dist/index.html;

done;
echo "</table></body></html>" >> dist/index.html
