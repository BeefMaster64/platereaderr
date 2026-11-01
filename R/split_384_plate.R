#' Split a 384-well plate into four 96-well plates
#'
#' Selects alternating rows and columns to reconstruct four
#' 96-well plates from a 384-well plates
#'
#' @param plate A data frame with rows A-P and columns 1-24
#' @return A named list of four data frames, each with rows A-H
#'   and columns 1-12
#' @export
split_384_plate <- function(plate) {

  #during the splitting each small plate takes the second row and second column of the large table
  #this way the 384 gets split in 4

  #specifying the starting points
  #the large plate "scanner" goes 1/1, 1/2, 2/1, 2/2
  row_start <- c(1, 1, 2, 2)
  col_start <- c(1, 2, 1, 2)

  #more purrr map (=lapply) to pair up starting rows and columns
  map2(row_start, col_start, function(row_start, col_start) {

    #selecting every second row and every second column
    selected_rows <- seq(row_start, 16, by = 2)
    selected_column <- seq(col_start, 24, by = 2)

    #extracting the selected rows and column from the OG plate
    small_plate <- plate[selected_rows, selected_column]

    #renaming the smaller plate's rows and columns from the GO one to new one
    #rows A-H and columns 1-12
    rownames(small_plate) <- LETTERS[1:8] #just learned about 'LETTERs' today
    colnames(small_plate) <- as.character(1:12)

    small_plate

  }) |> #pipe into the naming section

    #giving a name to the 4 small plates
    set_names(str_c("plate", 1:4))

}
