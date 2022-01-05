library(disk.frame)

dir_csv_files <- '~/Desktop/ny-cab-csv'
available_files <- fs::dir_ls(dir_csv_files)

df <- csv_to_disk.frame(
  infile = available_files,
  outdir = '~/Desktop/diskframe_nycab')


total_amm <- df |> 
  select(total_amount) |>
  collect() 

mean_total <- mean(total_amm$total_amount, na.rm = TRUE)

sd_total <- sd(total_amm$total_amount, na.rm = TRUE)

answer <- mean_total/sd_total

print(answer)