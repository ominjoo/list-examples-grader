CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

# scratch space for doing work on grading
mkdir grading-area

git clone $1 student-submission > gitClone-out.txt
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

# Copy all of the student's java files into grading-area
cp student-submission/*.java grading-area
# Copy all java files into grading-area
cp *.java grading-area
# Recursively copies everything in lib to grading-area
cp -r lib grading-area

# Change directories in the POV of the script to grading-area
cd grading-area

# Check for correct files 
if ! [ -f ListExamples.java ]
then
    echo "ERROR: Required file(s) not found!"
    echo "Score: 0"
    exit 1
fi

javac -cp $CPATH *.java
# Testing exit code
if [ $? -ne 0 ]
then
    echo "Compliation Error(s) detected"
    echo "Score: 0"
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-output.txt

linecount=$(wc -l < "test-output.txt")

if [ "$linecount" -gt 6 ]
then
    lastLine=$(cat test-output.txt | tail -n 2 | head -n 1)
    tests=$(echo $lastLine | awk -F'[, ]' '{print $3}')
    failures=$(echo $lastLine | awk -F'[, ]' '{print $6}')
    successes=$((tests - failures))
    echo "Score: $successes / $tests"
else
    echo "Score: 100%"
fi
