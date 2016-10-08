# Collatz Conjecture Representation

This project uses Python (with Numpy, FileInput and CSV libraries) and Processing.

The original idea for this project was to make a tree-like representation of the Collatz Conjecture paths. In case you didn't know, the Collatz Conjecture is an unresolved problem in mathematics, as it isn't proven to work but no counterexamples have been found. The problem is stated as a simple algorithm:
  1. Given a number n, if n is even, divide it by two. Otherwise, multiply it by three and add one to it.
  2. Call the solution n and repeat step 1.
  3. Prove that all natural numbers end in the 4 - 2 - 1 cicle.
  
Step 3 is yet unsolved, but we can check numbers to find patterns and / or counterexamples. For example, 

> 5 is odd; 3 * 5 + 1 = 16
>
> 16 is even; 16 / 2 = 8
>
> 8 is even; 8 / 2 = 4
>
> 4 is even; 4 / 2 = 2
>
> 2 is even; 2 / 2 = 1
>
> 1 is odd; 3 * 1 + 1 = 4
>
> 4 was already checked, we entered a loop.

You can easily do reverse engineering and draw tree-like representation of this algorithm:
  1. Start with n = 1. Draw a node for n, and two new branches to 2n and (n-1)/3, and call n as visited.
  2. For every unvisited node, repeat n.

I decided to do another type of representation following this second algorithm but instead of tree-like, I chose to do it in the number line.

## The program

There are 4 files in this project, 2 of which are just data bases.

In order to execute the project, first you have to calculate all the nodes you'll need up to a certain number. For this, I wrote the python program. When run, it returns two CSV files, which are stored in `/data`. The first one, `baseDatos.csv`, has all the visited nodes numbers. The other one, `cadenas.csv` is more interesting. It stores every node to which the Step 1 is applied along with the results, and it makes it very easy to figure out where to place the links later on.

Finally, the Processing file takes those outputs (the CSV files) and draws something like this:

![Screenshot of the Program](https://github.com/algc19/Collatz-Conjecture-Representation/blob/master/Captura.JPG)

In this visual representation, every arch (link) is connecting two nodes (numbers of the number line). The red lines represent the relation between n and 2n and the green ones the relation between n and 3n+1.

Note that there are some patterns. For example, a lot of red archs are "paralel" to each other, or following similar paths. That is because there are some long chains that are generated really quickly (as we are only checking the first 500 nodes following node 1). These are some of those chains:

 | 1 | 2 | 4 |  8 | 16 | 32 | 64 | 128 | 256 | 512 | 1024 | 2048 | 4096 |  8192 | 16384 | 32768 | 65536 | 131072 |
 | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
 |   |   | 5 | 10 | 20 | 40 | 80 | 160 | 320 | 640 | 1280 | 2560 | 5120 | 10240 | 20480 | 40960 | 81920 | 163840 |
 |   |   |   |    | 21 | 42 | 84 | 168 | 336 | 672 | 1344 | 2688 | 5376 | 10752 | 21504 | 43008 | 86016 | 172032 |
 |   |   |   |    |    |    | 85 | 170 | 340 | 680 | 1360 | 2720 | 5440 | 10880 | 21760 | 43520 | 87040 | 174080 |
 |   |   |   |    |    |    |    |     | 341 | 682 | 1364 | 2728 | 5456 | 10912 | 21824 | 43648 | 87296 | 174592 |
 |   |   |   |    |    |    |    |     |     |     | 1365 | 2730 | 5460 | 10920 | 21840 | 43680 | 87360 | 174720 |
 |   |   |   |    |    |    |    |     |     |     |      |      | 5461 | 10922 | 21844 | 43688 | 87376 | 174752 |
 |   |   |   |    |    |    |    |     |     |     |      |      |      |       | 21845 | 43690 | 87380 | 174760 |
 |   |   |   |    |    |    |    |     |     |     |      |      |      |       |       |       | 87381 | 174762 |

   
It is really easy to see the pattern in this table: all the red links represent either the 2^n path or a similar one. I don't quite understand why do chains star with 20+1, 84+1, 340+1 and so on but no chains start with 10+1, 42+1 or 170+1.
