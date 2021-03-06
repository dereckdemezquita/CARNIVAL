#'\code{write_constraints_4_all}
#'
#'@param variables Contains the list of variables as used to formulate the ILP problem, explanations for each variable and a list of useful indices.
#'
#'@return This code writes the list of constraints (4) of the ILP problem for all the conditions.

write_constraints_4_all <- function(variables=variables) {

  # ======================================= #
  # ====== Load write_constraints_4.R ===== #
  # ======================================= #

  write_constraints_4 <- function(variables=variables, conditionIDX=conditionIDX) {

    constraints4 <- rep("", length(variables$idxEdgesUp))

    idx1 <- which(variables$signs==1)
    idx2 <- which(variables$signs==-1)

    constraints4[idx1] <- paste0(variables$variables[variables$idxEdgesUp[idx1]], " - ",
                                 variables$variables[match(paste0("Species ",
                                                                  unlist(strsplit(gsub(gsub(variables$exp[variables$idxEdgesUp[idx1]], pattern = "ReactionUp ", replacement = ""), pattern = paste0(" in experiment ", conditionIDX), replacement = ""), split = "="))[c(TRUE, FALSE)],
                                                                  " in experiment ", conditionIDX), variables$exp)], " - ",
                                 variables$uTable[match(variables$variables[variables$idxEdgesUp[idx1]], variables$uTable[, 1]), 2],
                                 " <= 0")

    constraints4[idx2] <- paste0(variables$variables[variables$idxEdgesUp[idx2]], " + ",
                                 variables$variables[match(paste0("Species ",
                                                                  unlist(strsplit(gsub(gsub(variables$exp[variables$idxEdgesUp[idx2]], pattern = "ReactionUp ", replacement = ""), pattern = paste0(" in experiment ", conditionIDX), replacement = ""), split = "="))[c(TRUE, FALSE)],
                                                                  " in experiment ", conditionIDX), variables$exp)], " - ",
                                 variables$uTable[match(variables$variables[variables$idxEdgesUp[idx2]], variables$uTable[, 1]), 2],
                                 " >= 0")

    return(constraints4)

  }

  # ======================================= #
  # ======================================= #
  # ======================================= #

  constraints4 <- c()

  for(i in 1:length(variables)){

    var <- variables[[i]]

    constraints4 <- c(constraints4, write_constraints_4(variables = var, conditionIDX = i))

  }

  return(constraints4)

}
