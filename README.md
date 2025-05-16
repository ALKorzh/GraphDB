# GraphDB - Graph Database Social Network Project

## Overview
This project demonstrates the modeling and analysis of a social network using the graph database capabilities of SQL Server. It creates and explores a simplified social network model that represents relationships between people, their interests, and where they live.

## Project Structure
- `task1-6.sql` - SQL script containing database setup, data creation, and graph queries
- `GraphSocialNetwork.bak` - SQL Server database backup file
- `GraphDBVisualization.pbix` - Power BI visualization file
- `GraphDBVisualization.drawio` - Draw.io visualization file
- `images/` - Various visualizations of the graph relationships

## Features
- Graph database modeling with nodes (Person, City, Interest) and edges (FriendOf, LivesIn, HasInterest)
- Implementation of graph queries using SQL Server's MATCH syntax
- Visualization of social networks in multiple formats
- Analysis of friend relationships, common interests, and geographic connections

## Database Schema
The database consists of three node tables:
- **Person**: Individuals in the social network
- **City**: Locations where people live
- **Interest**: Hobbies and interests of individuals

And three edge tables:
- **FriendOf**: Represents friendship relationships between people
- **LivesIn**: Connects people to their cities of residence
- **HasInterest**: Links people to their interests/hobbies

## How to Use
1. Restore the database using the provided .bak file or run the SQL script
2. Execute the queries in the SQL script to explore various graph relationships
3. Open the visualization files to view graphical representations of the network

## Visualizations
The project includes multiple visualizations showing different aspects of the social network:
- Friend relationships between individuals
- Distribution of interests/hobbies among people
- Geographic distribution of people across cities

## Technologies Used
- SQL Server with Graph Database Features
- T-SQL with MATCH syntax
- Power BI for interactive visualizations
- Draw.io for network diagrams
