#!/bin/bash

PSQL="psql  -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

INPUT=$1

#if the user didn't use an input
if [[ -z $INPUT ]]
then
  echo "Please provide an element as an argument."
else #if input exists

  #If the input is not a number
  if [[ ! $INPUT =~ ^([0-9]|10)$ ]]
  then
    if [[ $(expr length "$INPUT") -gt 2 ]] #input is a name
    then
      #get info by name
      INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$INPUT'")

      if [[ -z $INFO ]]
      then
        echo "I could not find that element in the database."
      else
        echo $INFO | while read TYPE_ID BAR AN BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
        do
          echo "The element with atomic number $AN is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    
    else #input is a symbol
      #get info by symbol
      INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$INPUT'")


      if [[ -z $INFO ]]
      then
        echo "I could not find that element in the database."
      else
        echo $INFO | while read TYPE_ID BAR AN BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
        do
          echo "The element with atomic number $AN is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi

    fi
  else #input is the atomic_number
    #get info by atomic_number
    INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = '$INPUT'")

    if [[ -z $INFO ]]
    then
      echo "I could not find that element in the database."
    else
      echo $INFO | while read TYPE_ID BAR AN BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
      do
        echo "The element with atomic number $AN is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi
  fi
fi
