rm(list=ls())
library(tidyverse)
library(readxl)
library(sna)
library(network)
library(snahelper)
library(writexl)

######################################
#SOCIAL NETWORK ANALYSIS 1982 BERETTA#
######################################
setwd("C:/Users/dapaf/OneDrive/Desktop/P2_1980-1982")

Network_1982 <- read_excel("Network_1982.xlsx")

sources = Network_1982 %>%
  distinct(Source) %>%
  rename(label = Source)

destinations = Network_1982 %>%
  distinct(Destination) %>%
  rename(label = Destination)

#NODI 1982
Nodes1982 <- full_join(sources, destinations, by = "label")
Nodes1982 <- Nodes1982 %>% rowid_to_column("id")

#MATRICE COLLEGAMENTI E PESI
Network_1982W = Network_1982 %>%  
  group_by(Source, Destination) %>%
  summarise(Weight = n()) %>% 
  ungroup()

#MATRICE COLLEGEMANTI E PESI CON ID
Edges1982 <- Network_1982W %>% 
  left_join(Nodes1982, by = c("Source" = "label")) %>% 
  rename(from = id)

Edges1982 <- Edges1982 %>% 
  left_join(Nodes1982, by = c("Destination" = "label")) %>% 
  rename(to = id)

#OUTPUT GRAFICO
routes_network1982 <- network(Edges1982, vertex.attr = Nodes1982, matrix.type = "edgelist", ignore.eval = FALSE)
plot(routes_network1982, vertex.cex = 3)

#SEMPLICE
detach(package:network)
rm(routes_network1982)
library(igraph)

routes_igraph1982 <- graph_from_data_frame(d = Edges1982[,3:5], vertices = Nodes1982, directed = TRUE)
plot(routes_igraph1982, edge.arrow.size = 0.2)
plot(routes_igraph1982, layout = layout_with_graphopt, edge.arrow.size = 0.2)

#COMPLESSO
library(tidygraph)
library(ggraph)


routes_tidy1982 <- tbl_graph(nodes = Nodes1982, edges = Edges1982[,-c(1:2)], directed = TRUE)

#routes_igraph_tidy1982 <- as_tbl_graph(routes_igraph1982)

routes_tidy1982 %>% 
  activate(edges) %>% 
  arrange(desc(Weight))

class(routes_tidy1982)

routes_tidy1982 %>% 
  activate(nodes) %>% 
  arrange(desc(Weight))

dev.off()
ggraph(routes_tidy1982) + geom_edge_link() + geom_node_point() + theme_graph()

set.seed(1)
ggraph(routes_tidy1982, layout = "stress") + 
  geom_node_point() +
  geom_edge_link(aes(width = Weight), alpha = 0.8) + 
  scale_edge_width(range = c(0.2, 2)) +
  geom_node_text(aes(label = label), repel = TRUE) +
  labs(edge_width = "Number of Links") +
  theme_graph()

#INDICI DI CENTR. 1982
edges.mat1982 = as.matrix(Edges1982[,4:5], ncol=2, dimnames=c('from','to'))
pkg.graph1982 = graph_from_edgelist(edges.mat1982, directed = FALSE)
class(pkg.graph1982)
show(pkg.graph1982)
pkg.pagerank1982 = page.rank(pkg.graph1982, directed = FALSE)
show(pkg.pagerank1982)
pkg.ev1982 = evcent(pkg.graph1982, directed = FALSE)
show(pkg.ev1982)

output1982 = Nodes1982
output1982$Degree = degree(pkg.graph1982)
output1982$Btw = betweenness(pkg.graph1982)
output1982$CI = closeness(pkg.graph1982)
output1982$Eigen = evcent(pkg.graph1982)$vector
Std.Degree1982 = (output1982$Degree-mean(output1982$Degree))/
  (sqrt(var(output1982$Degree)*(length(output1982$Degree)-1)/(length(output1982$Degree))))
Std.Btw1982 = (output1982$Btw-mean(output1982$Btw))/
  (sqrt(var(output1982$Btw)*(length(output1982$Btw)-1)/(length(output1982$Btw))))
Std.CI1982 = (output1982$CI-mean(output1982$CI))/
  (sqrt(var(output1982$CI)*(length(output1982$CI)-1)/(length(output1982$CI))))

#output1982$Std.Mean
library(openxlsx)
write.xlsx(output1982,"C:/Users/dapaf/OneDrive/Desktop")
