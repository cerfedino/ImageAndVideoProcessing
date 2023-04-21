H = [-1 -2 0; -2 0 3; 0 3 1]

[U, S, V] = svd(H)
k1 = sqrt(S(1,1)) * U(:,1)
k2 = sqrt(S(1,1)) * V(:,1)'


matrix2tablebody(H, "out/1.3.H.tex", "%0.2f")
matrix2tablebody(k1, "out/1.3.k1.tex", "%0.4f")
matrix2tablebody(k2, "out/1.3.k2.tex", "%0.4f")
matrix2tablebody(U, "out/1.3.U.tex", "%0.2f")
matrix2tablebody(S, "out/1.3.S.tex", "%0.2f")
matrix2tablebody(V, "out/1.3.V.tex", "%0.2f")