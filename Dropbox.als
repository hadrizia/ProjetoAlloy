module Dropbox

sig Conta{
conta_dropbox: some DropBoxObject,
dispositivo: set Dispositivo}

sig DropBoxObject{}

sig Pasta extends DropBoxObject{
	conteudo: set DropBoxObject}

sig Arquivo extends DropBoxObject{}

sig Musica extends Arquivo{}
sig Video extends Arquivo{}
sig Imagem extends Arquivo{}
sig Texto extends Arquivo{}

sig Dispositivo{
tipo_de_permissao: one Tipo
}

sig Computador extends Dispositivo{}
sig IPhone extends Dispositivo{}
sig Android extends Dispositivo{}

sig Tipo{}
sig Leitura extends Tipo{}
sig Escrita extends Tipo{}
sig Leitura_e_Escrita extends Tipo{}

fact Diretorios{
all p: Pasta | (p !in p.^conteudo)  //&&  some p.conteudo
all d: DropBoxObject | (d in Pasta || d in Arquivo) && lone d.~conteudo
all p1, p2: Pasta | (p1 != p2) => p1.conteudo != p2.conteudo


}

fact Permissoes{
all p: Dispositivo| (p in Computador) || (p in IPhone) || (p in Android)
all t:Tipo | (t in Leitura) ||  (t in Leitura_e_Escrita)
all d:Dispositivo | (d in IPhone || d in Android) => (d.tipo_de_permissao = Leitura)
all d:Dispositivo | (d in Computador) => (d.tipo_de_permissao = Leitura_e_Escrita)

}

fact Conta{
one Conta
one Leitura_e_Escrita
one Leitura

all d:Dispositivo | d in Conta.dispositivo
one d:Pasta | d in Conta.conta_dropbox
all d:DropBoxObject, p:Pasta, c:Conta | (d in c.conta_dropbox) => d !in p.conteudo
all d: DropBoxObject, c: Conta | (d in (c.conta_dropbox)) || (d in (c.conta_dropbox).^conteudo)

}


pred show[]{
#Dispositivo = 2
}

run show for 5
