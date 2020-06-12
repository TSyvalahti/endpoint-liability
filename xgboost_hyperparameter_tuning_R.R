# This script is for xgboost hyperparameter tuning
# with Bayesian optimization.

library(MlBayesOpt)
set.seed(1001)

# Make sure there are positive cases in cv test sets!
# acq = acquisition function. 
# Try either "ei"= expected improvement or "ucb"= upper confidence bound
# The model did not work with default seed = 0, 
# make sure to redefine it inside the function!
model <- xgb_cv_opt(data = train_data,
                    label = I9_STR_EXH,
                    objectfun = "binary:logistic",
                    evalmetric = "auc",
                    n_folds = 10,
                    eta_range = c(0.1, 1),
                    max_depth_range = c(4L, 6L),
                    nrounds_range = c(70L, 160L),
                    subsample_range = c(0.1, 1),
                    bytree_range = c(0.4, 1),
                    init_points = 5,
                    n_iter = 10,
                    acq = "ei",
                    seed = 1001)
model$Best_Par

# # Optional: xgboost parameter tuning without crossvalidation
# model2 <- xgb_opt(train_data = train_data,
#                  train_label = I9_STR_EXH,
#                  test_data = test_data,
#                  test_label = I9_STR_EXH,
#                  objectfun = "reg:logistic",
#                  evalmetric = "auc",
#                  init_points = 4,
#                  n_iter = 2)
# model2$Best_Par