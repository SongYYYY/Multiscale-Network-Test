print.lambda = function(L, times){

  maps = list()
  
  pi = statdistr(L)
  isolated = which(pi <= 0)
  pi[isolated] = 0
  pi.mat1 = as.matrix(Diagonal(length(pi), pi^(1/2)))
  pi.mat2 = as.matrix(Diagonal(length(pi), pi^(-1/2)))
  
  pi.mat1[,isolated] = 0
  pi.mat2[,isolated] = 0
  
  # symmetric kernel
  Q = pi.mat1 %*% L %*% pi.mat2
  
  Q[,isolated] = 0
  Q[,isolated] = 0
  
  lambda = Re(eigen(Q)$values)[Im(eigen(Q)$value) == 0]
  psi = Re(eigen(Q)$vectors)[,Im(eigen(Q)$value) == 0]
  
  phi = pi.mat2 %*% psi
  
  Lambda = as.matrix(Diagonal(length(lambda), lambda))
  
  lambda.set = list()
  for(t in 1:length(times)){
    lambda.set[[t]] = lambda^(times[t])  
  }  
  return(lambda.set)
}

dmap.q = function(L, times, q){

  maps = list(); maps.q = list()
  
  # stationary distribution (probability)
  pi = statdistr(L)
  isolated = which(pi <= 0)
  pi[isolated] = 0
  pi.mat1 = as.matrix(Diagonal(length(pi), pi^(1/2)))
  pi.mat2 = as.matrix(Diagonal(length(pi), pi^(-1/2)))
  
  pi.mat1[,isolated] = 0
  pi.mat2[,isolated] = 0
  # symmetric kernel
  
  Q <- pi.mat1 %*% L %*% pi.mat2
  
  Q[,isolated] = 0
  Q[,isolated] = 0
  
  lambda = Re(eigen(Q)$values)[Im(eigen(Q)$value) == 0]
  psi = Re(eigen(Q)$vectors)[,Im(eigen(Q)$value) == 0]
  
 
  phi = pi.mat2 %*% psi
  
  Lambda = as.matrix(Diagonal(length(lambda), lambda))
  
  # each row of maps is a diffusion maps of each vertex
  for(t in 1:length(times)){
    maps[[t]] <- phi %*% Lambda^(times[t]) 
    maps.q[[t]] <- maps[[t]][,1:q]
  }
 
  return(maps.q)
}