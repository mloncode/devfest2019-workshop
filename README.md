# Content:

* Description of workshop
* TLDR - Promised projects
* Pipeline for `developer clustering`
* Pipeline for `searching similar projects`
* Pipeline for `name suggestion`
* Common parts of the pipelines

## Description of workshop:
<details> <summary>click</summary>

```
Machine Learning on Source Code (MLonCode) is an emerging and exciting research domain which stands at the sweet spot between deep learning, natural language processing, social science, and programming.

During this 2 hours workshop, we are going to show you how to extract insights from code bases—step by step—by shedding light on those crucial aspects:

What information is available in your code
* How to extract this information
* What can you do with this knowledge: what are the tasks solvable by MLonCode
* Which models can be used to solve them

To get our hands dirty, we will solve several example tasks, using source{d}, an open source stack to gain insights from codebases:
* Suggest function names automatically
* Cluster developers
* Search projects by similarity

Prerequisites: a laptop with Docker installed. We will provide an image to all participants.
```

</details>

## TLDR - Promised projects:
```
* Suggest function names automatically
* Cluster developers
* Search projects by similarity

Prerequisites: a laptop with Docker installed. We will provide an image to all participants.
```

I prepared the presentation recently for one conference - https://egorbu.github.io/usedata_2019/, 

## Pipeline for `developer clustering`:

Developer clustering consists of 2 parts - `Topic Modeling pipeline` and `Developer Experience pipeline`, `Developer features & so on`

### Topic Modeling pipeline

1. Discover repositories - prepare a list of repositories for an experiment
2. Clone
3. Checkout head revision
4. Classify files
5. Filter - delete vendor, binary files and other stuff
6. Parse
7. Split identifiers: `set_time` -> `[set, time]`
7. Prepare `file`: `weighted Bag-of-words`
<details> <summary>optional steps</summary>

* Launch topic modeling per file
* Visualize topics

</details>

### Developer Experience pipeline
1. Discover repositories - prepare a list of repositories for an experiment
2. Clone
3. Iterate through commits:
    * Classify files
    * Filter - delete vendor, binary files and other stuff
    * Identity matching: `author name/email` -> `dev_id`
    * Create/update `dev_id`: `language experience`
    * Create/update `dev_id`: `file modification rate`

### Developer features & so on

* Language experience features
* Topic modeling
    * `file-token` matrix multiply by `dev_id-file` matrix -> `dev_id-token` matrix -> topic modeling
    * train TM on `file-token` matrix, use `dev_id-file` matrix to make weighted sum of topics per `dev_id`
* Clustering / dimensionality reduction / Kd-trees to search for similar developers and so on

## Pipeline for `developer clustering`:

Developer clustering consists of 2 parts - `Topic Modeling pipeline` and `Developer Experience pipeline`, `Developer features & so on`

## Pipeline for `searching similar projects`

1. Discover repositories - prepare a list of repositories for an experiment - it should be a DB to query
2. Clone
3. Checkout head revision
4. Classify files
5. Filter - delete vendor, binary files and other stuff
6. Parse
7. Split identifiers: `set_time` -> `[set, time]`
7. Prepare `repo`: `weighted Bag-of-words`
8. Create embeddings per token (could be a separate task but most probably should use `fasttext`) 
9. `repo`: `weighted bag-of-embeddings` -> Word Mover's Distance
10. query functionality

## Pipeline for `name suggestion`

1. Discover repositories - prepare a list of repositories for an experiment - it should be a DB to query
2. Clone
3. Checkout head revision
4. Classify files
5. Filter - delete vendor, binary files and other stuff
6. Parse
7. Create pairs `function/class name`: `body`
    * extract features from the body - identifiers, structural and so on - this could be filled by listeners
7. Train transformer-based model (the easiest one because it may work with an unordered set of features)
8. Function to suggest name

## Common parts of the pipelines
1. Discover repositories - prepare a list of repositories for an experiment - it should be a DB to query
2. Clone
3. Checkout head revision
4. Classify files
5. Filter - delete vendor, binary files and other stuff
6. Parse

but developer experience requires traversing of the commits - probably still could be done with `gitbase` - [functionality](https://github.com/src-d/gitbase/blob/master/docs/using-gitbase/functions.md#gitbase-functions)
