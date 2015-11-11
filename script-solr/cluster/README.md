script-solr - cluster setup
===========================

To cluster or setup a SolrCloud environemnt, one can run the stand-alone version on multiple nodes to setup a SolrCloud with proper sharding and replication.

For example:
------------

Let's say we want to setup a 3-node SolrCloud, we'll run the stand-alone script one node1, node2, and node3 to setup a SolrCloud with

- 3 Solr instances per node
  This allows data to be replicated or backed up onto other nodes that are part of the SolrCloud or having the same Solr Collection name

- 3 shards
  This allows data to be spread out into 3 shards

Advantages
----------
- data stored is distributed and can be searched across all shards or on specific shard

- data in each shard is stored 3 times in 3 different nodes. If one or two physical nodes are down, the data is still available for searching

- sharding and replication are automatically taken care of by Solr so they are transparent during indexing and searching

Disadvantages
-------------
- since data is spread into 3 shards, the overall performance is affected during indexing process

- since data is replicated to other nodes (or stored three times) in the SolrCloud, the overall performance is affected during indexing process
