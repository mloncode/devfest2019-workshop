# Pipelines overview

In this document we give a broad overview of the steps applied for each tasks:

- Developer clustering
- Similar projects search
- Function name suggestion

All these build on a common data gathering step and on similar preprocessing .

Our very own [Egor Bulychev](https://github.com/EgorBu) recently gave [a talk](https://egorbu.github.io/usedata_2019/) on similar tasks if you want a slightly different angle to refer to.

## Data Gathering

For this workshop, we'll use one of the cornerstones of open source as a data source: the Apache Software Foundation (ASF). We'll gather their fifty most popular repositories (as judged by number of stars on GitHub), only discarding the biggest ones (to keep everything fast to run).

This mostly comprises those steps:

1. Discover ASF repositories with GitHub API
2. Filter out the largest ones by size and find out which are the most popular by stars
3. Clone the 50 most popular

## Task-specific pipelines

### Similar projects search

Using the repositories we've cloned, we prepare a [topic model](https://en.wikipedia.org/wiki/Topic_model) based on the identifiers their files contain. This will allow us to categorize each project as pertaining to a given list of topics and will make their clustering and search easy. To do that, we need to accomplish a few things:

1. Filter out uninteresting files (vendor files, binary files, …)
2. Parse them into a list of identifiers
3. Split the identifiers: `set_time` → `[set, time]`
4. Prepare a weighted bag of split identifiers per file
5. Train a topic model on those bags
6. Visualize the trained topics
7. Aggregate the topics of the files into topics of a repository
8. Code a way to retrieve the most similar repos to a given one given their topics

### Developer clustering

Even though we could go in other directions, we base the developer clustering on the similar projects pipeline: using the topic model trained on files, we'll find out the contributions of developers to each file to understand which topics the master.

1. Filter out uninteresting files (vendor files, binary files, …)
2. Parse them into a list of identifiers
3. Split the identifiers: `set_time` → `[set, time]`
4. Prepare a weighted bag of split identifiers per file
5. Train a topic model on those bags
6. Visualize the trained topics
7. Compute the contribution of each developer to each file
8. Derive topics for developers from their contributions
9. Code a way to retrieve similar developers given their topics

### Function name suggestion

1. Filter out uninteresting files (vendor files, binary files, …)
2. Parse them into a mapping of function name → list of identifiers
3. Split the identifiers: `set_time` → `[set, time]`
4. Train a translation model from list of identifiers to function names
