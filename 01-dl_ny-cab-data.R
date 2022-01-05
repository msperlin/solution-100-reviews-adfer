
dir_csv_files <- '~/Desktop/ny-cab-csv'
all_months <- stringr::str_pad(1:12, 
                               width = 2, 
                               side = 'left', 
                               pad = "0")
this_year <- 2018

  
if (!dir.exists(dir_csv_files)) dir.create(dir_csv_files)

dl_single_file <- function(month, year) {
  
  cli::cli_alert_info('fetching ny-cab data for {month}/{year}')

  local_file <- fs::path(dir_csv_files, 
                         stringr::str_glue('ny-cab-{month}-{year}.csv')) 
  
  if (file.exists(local_file)) {
    cli::cli_alert_success('\tFile already exist :)')
    return(TRUE)
  }
  
  base_link <- 'https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_%s-%s.csv'
  
  
  dl_link <- sprintf(base_link, 
                     year, month)
  
  cli::cli_alert_info('\tDownloading file')
  downloader::download(dl_link, local_file, mode="wb")
  
  return(TRUE)
  
}

df_grid <- expand.grid(months = all_months, year = this_year)

purrr::pwalk(.l = list(month = df_grid$months,
                       year = df_grid$year), 
             .f = dl_single_file)
