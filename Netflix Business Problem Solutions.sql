----Netflix Project-----

create table netflix(show_id varchar(6),type varchar(10),title varchar(150),
                     director varchar(250),casts varchar(1000),country varchar(150),
					 date_added varchar(50),release_year int,rating varchar(10),duration varchar(10),
					 listed_in varchar(100),description varchar(250));
                     
select * from netflix


select count(*) from netflix







 -------- 15 Business Problems ------------




	 Q1- Count the number of movies vs TV shows?

	 Ans- select type,count(*) as Total_Content from netflix
	         group by type






    Q.2 Find the most common rating for movies and TV shows?
	
	Ans:		  
         with t1 as
			  (select Type,Rating,count(rating) as Most_Common_Rating,
			  rank() over (Partition by type order by count(rating) desc) as Ranking
			  from netflix
		      group by type,rating) 

		select type,rating,most_common_rating, Ranking from t1
	           where ranking=1	  






   Q.3 List all the movies released 2010?

   Ans: select type,title from netflix
        where type= 'Movie'
		and release_year= 2010






	Q.4 Find the top 5 countries with the most content on netflix? 

	Ans:    select unnest(string_to_array(country, ',')) AS new_country, count(show_id)
	        from netflix
			group by 1
			order by 2 desc







   Q.5  Find the longest movie or TV show duration?

   Ans:  --Maximum Duration movie:

      select type,title,duration
      from netflix
	  where type= 'Movie'
	        and duration= (select max(duration) from netflix)  


     --Most no. of Seasons in a TV show: (fir se krenge)

      select title,type,split_part(duration,' ',1) as seasons
	     from netflix
		 where type='TV Show'
		 order by 3 desc
		 limit 1



	  


    Q.6 Find content added in last 5 years?(Nhi hua)

    Ans: select * from netflix
	       where to_date(date_added,'Month-DD-YYYY')>=current_date - interval'5 years'





   Q.7 Find all the movies/TV shows directed by 'Rajiv Chilaka'?

   Ans: select title from netflix
      where director like'%Rajiv Chilaka%'




   Q.8  TV sh0ws with more than 5 seasons? 
	
   Ans: select type,title, split_part(Duration,' ',1) as Seasons
	 from netflix
	    where type='TV Show' 
		     and split_part(Duration,' ',1):: numeric>5





   Q.9  Count no. of items in each genre?

   Ans: select unnest(string_to_array(listed_in,' ')),count(show_id)
          from netflix
         group by 1




  Q.10 Find each year and avg numbers of content release by India on netflix. Return top 5 year with highest avg content release?

  Ans: select extract(year from to_date(date_added,'Month-DD- YYYY')) as Year,
              count(show_id),
			  round(count(show_id):: numeric/(select count(show_id) from netflix where country='India')* 100,2)
		from netflix
		where country = 'India'
		group by 1





   Q.11 List all the movies that are in docmentaries?

   Ans: select * from netflix
          where listed_in Ilike '%documentaries%'
		       




  Q.12 Find all content without a director?

  Ans: select * from netflix
        where director is null





  Q.13 Find how many movies actor ' Salman Khan' appeared in last 10 years?

  Ans: select * from netflix
      where casts ilike'% salman khan%'





  Q.14 Find top 10 actors who have appeared in the highest number of movies produced in India?

  Ans: select unnest(string_to_array(casts,',')) as Actors,
             count(show_id)
	    from netflix
		    where type='Movie'
			      and country ilike'%india%'
		group by 1
		order by 2 desc
         limit 10

select * from netflix


    Q,15 Categorize the content based on the presence of the keywords 'Kill' and 'Violence' in
	     the description field. Label content containing these keywords as 'Bad' and all other
		 content as 'Good'. Count how many items fall into each category?


    Ans: with C1 as(
	      select title,
	        case when description ilike'%Kill%' or
			          description ilike'%violence%' then 'Bad Content'
			else 'Good Content'
			end as Category
		from netflix)

		select category,count(title) as Content_Count
		   from C1
		   group by category



		 


		
  





   












