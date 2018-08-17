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
.md5, .diff{
    font-size:10px;
}
</style>
<body>
<h1>Test Results</h1>
<div><a href='https://github.com/dissolve/mf2-tester'>Source</a></div>
<br><br><br>
<table>" > dist/index.html
TEST_SUITE_VERSION=`bash scripts/tests-version.sh`;
PHP_VERSION=`bash scripts/php-version.sh`;
PYTHON_VERSION=`python scripts/python-version.py`;
RUBY_VERSION=`ruby scripts/ruby-version.rb`;
echo "<tr>
<th>Test</th>
<th>Test Suite <div class='version'>$TEST_SUITE_VERSION</div></th>
<th>PHP <div class='version'>$PHP_VERSION</div></th>
<th>Python <div class='version'>$PYTHON_VERSION</div></th>
<th>Ruby <div class='version'>$RUBY_VERSION</div></th>
</tr>" >> dist/index.html
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
        echo '<td class="'$CLASS'">Test Suite: <a href="'$RESULT'">View</a><br><span class="md5">'$RESULT_MD5'</span></td>' >> dist/index.html;

        PHP_RESULT_MD5=`md5sum $PHP_RESULT |cut -d ' ' -f 1`;

        if [ "$RESULT_MD5" = "$PHP_RESULT_MD5" ]; then
            echo "<td class='pass'>Result: <a href='$PHP_RESULT'>View</a> <br><span class='md5'>$PHP_RESULT_MD5</span></td>" >> dist/index.html;
        else
            diff $RESULT $PHP_RESULT > $PHP_RESULT.diff.txt
            echo "<td class='fail'>Result: <a href='$PHP_RESULT'>View</a> <br><span class='md5'>$PHP_RESULT_MD5</span>
            <div class='diff'><a href='$PHP_RESULT.diff.txt'>Diff</a></div>
            </td>" >> dist/index.html;
        fi

        PYTHON_RESULT_MD5=`md5sum $PYTHON_RESULT |cut -d ' ' -f 1`;
        if [ "$RESULT_MD5" = "$PYTHON_RESULT_MD5" ]; then
            echo "<td class='pass'>Result: <a href='$PYTHON_RESULT'>View</a> <br><span class='md5'>$PYTHON_RESULT_MD5</span></td>" >> dist/index.html;
        else
            diff $RESULT $PYTHON_RESULT > $PYTHON_RESULT.diff.txt
            echo "<td class='fail'>Result: <a href='$PYTHON_RESULT'>View</a> <br><span class='md5'>$PYTHON_RESULT_MD5</span>
            <div class='diff'><a href='$PYTHON_RESULT.diff.txt'>Diff</a></div>
            </td>" >> dist/index.html;
        fi

        RUBY_RESULT_MD5=`md5sum $RUBY_RESULT |cut -d ' ' -f 1`;
        if [ "$RESULT_MD5" = "$RUBY_RESULT_MD5" ]; then
            echo "<td class='pass'>Result: <a href='$RUBY_RESULT'>View</a> <br><span class='md5'>$RUBY_RESULT_MD5</span></td>" >> dist/index.html;
        else
            diff $RESULT $RUBY_RESULT > $RUBY_RESULT.diff.txt
            echo "<td class='fail'>Result: <a href='$RUBY_RESULT'>View</a> <br><span class='md5'>$RUBY_RESULT_MD5</span>
            <div class='diff'><a href='$RUBY_RESULT.diff.txt'>Diff</a></div>
            </td>" >> dist/index.html;
        fi

done;
echo "</table></body></html>" >> dist/index.html
