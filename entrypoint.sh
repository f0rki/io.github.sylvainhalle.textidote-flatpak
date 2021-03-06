#!/bin/bash
set -e

JAVA=/app/jre/bin/java

# convencience script for downloading languagetool n-gram data
if test "$1" = "download-ngram" ;then
    LM_URL=https://languagetool.org/download/ngram-data
    case $2 in
        en)
            LM=en
            LM_FILE=ngrams-en-20150817.zip
            ;;
        de)
            LM=en
            LM_FILE=ngrams-de-20150819.zip
            ;;
        es)
            LM=es
            LM_FILE=ngrams-es-20150915.zip
            ;;
        fr)
            LM=fr
            LM_FILE=ngrams-fr-20150913.zip
            ;;
        nl)
            LM=nl
            LM_FILE=ngrams-nl-20181229.zip
            ;;
        *)
            echo "Unsupported language n-gram! (was '$2')"
            echo "supported languages: en, de, es, fr, nl"
            echo ""
            exit 1
    esac
    pushd "$XDG_DATA_HOME/languagemodel/"

    if test -d "$LM"; then
        echo "Language n-gram files already downloaded!"
        exit 0
    else
        echo "Downloading n-gram file! $LM_URL/$LM_FILE"
        curl "$LM_URL/$LM_FILE" > "$LM_FILE" 
        unzip "$LM_FILE"
        rm "$LM_FILE"
        exit 0
    fi

    popd >/dev/null
fi

if test "$1" = "view-report"; then
    dir=$(dirname "$1")
    pushd $dir > /dev/null
    java -jar /opt/textidote/textidote.jar --check en --output html "$@" > /tmp/textidote.html
    popd > /dev/null
    exec xdg-open /tmp/textidote.html
fi

exec $JAVA \
    -jar /app/lib/textidote.jar \
    $@
    #--languagemodel "$XDG_DATA_HOME/languagemodel/" \
