module Dropbox

sig DropBoxObject{}

sig Arquivo extends DropBoxObject{}

sig Pasta extends DropBoxObject{
	conteudo: set DropBoxObject}

fact{
all p: Pasta | p !in p.^conteudo && some p.conteudo
all d: DropBoxObject | (d in Pasta || d in Arquivo) && lone d.~conteudo
all p1, p2: Pasta | (p1 != p2) => p1.^conteudo != p2.conteudo

}

pred show[]{}

run show for 4
