-- List all bands with Glam Rock as their main style
-- Rank them by their longevity (lifespan in years until 2022)

SELECT band_name, 
       CASE 
           WHEN split IS NULL THEN 2022 - formed 
           ELSE split - formed 
       END AS lifespan
FROM metal_bands
WHERE main_style = 'Glam Rock'
ORDER BY lifespan DESC;
