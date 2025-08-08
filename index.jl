### A Pluto.jl notebook ###
# v0.20.13

#> [frontmatter]
#> image = "https://github.com/Ricardo-Luis/me-2/blob/9286b03f000c773f8811a67dc6649fba00f9d6c8/images/card/qr-code.svg?raw=true"
#> site_name = "Notebooks Computacionais Aplicados a Máquinas Elétricas II"
#> title = "Notebooks Computacionais Aplicados a Máquinas Elétricas II"
#> date = "2025-01-09"
#> tags = ["Pluto Notebooks", "Electric Machines", "DC Machines", "Synchronous Machines", "Transients of Electrical Machines"]
#> url = "https://ricardo-luis.github.io/me-2/"
#> description = "Luís, Ricardo (2025). Notebooks Computacionais Aplicados a Máquinas Elétricas II. Instituto Superior de Engenharia de Lisboa, Licenciatura em Engenharia Eletrotécnica. Disponível em: https://ricardo-luis.github.io/me-2/"
#> 
#>     [[frontmatter.author]]
#>     name = "Ricardo Luís"
#>     url = "https://ricardo-luis.github.io"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 766e42e6-0d19-48ba-b1a5-462708df3ff9
using PlutoUI, PlutoTeachingTools   # packages needed for this notebook

# ╔═╡ 2e32c42e-7736-43e0-bff0-966cbbadc732


# ╔═╡ f0ff75df-7efd-4628-830c-b4af68ac09d4


# ╔═╡ d4933445-95c9-4f86-a832-95278e8aa34c
md"""

# Visão geral

Este *website* disponibiliza a leitura e o acesso a uma coleção de *notebooks* na forma de notas de aula e cálculos de engenharia, de apoio à unidade curricular de Máquinas Elétricas II (ME II), do curso de Licenciatura em Engenharia Eletrotécnica do ISEL -- Instituto Superior de Engenharia de Lisboa.

Os *notebooks* são documentos computacionais que utilizam o navegador *web*, integrando o desenvolvimento e os resultados de execução, com texto explicativo, expressões matemáticas, tabelas, imagens, entre outros, de forma interligada e interativa com o utilizador. Esta metodologia procura integrar a aprendizagem teórica com as características operacionais das máquinas elétricas.

Estes *notebooks* são desenvolvidos utilizando o **`Pluto.jl`**, um ambiente de desenvolvimento integrado simples e reativo para a linguagem de computação científica **`Julia`**. Esta abordagem imersiva permite aos estudantes explorar conceitos complexos de forma dinâmica, estabelecendo pontes entre o conhecimento académico e os desafios reais da engenharia. O objetivo é estimular um domínio mais efetivo e prático dos conteúdos, contribuindo para o desenvolvimento de competências essenciais ao exercício da engenharia.
"""

# ╔═╡ 1eb0fa23-13f7-4dd2-b4b8-b8a6d802d90c


# ╔═╡ 659cda0d-61f1-4e65-b541-9d5e6c69bab2
md"""
# Notebooks ME II
"""

# ╔═╡ ca020f4c-e830-4eb1-8284-308551465919
NotebookCard("https://ricardo-luis.github.io/me-2/ACpower.html")

# ╔═╡ 3851b901-0f6f-4771-8adb-7820a7b60465
NotebookCard("https://ricardo-luis.github.io/me-2/RLcircuit.html")

# ╔═╡ a80136eb-b0fa-4062-8889-2c90976369a3
NotebookCard("https://ricardo-luis.github.io/me-2/PowerMap.html")

# ╔═╡ 1f3385c5-e2cb-4b36-af2c-3ca16e7dc4f1


# ╔═╡ 379a42a7-8f18-42de-bdc0-5601561196dd
NotebookCard("https://ricardo-luis.github.io/me-2/MaqDCinduzido.html")

# ╔═╡ fc130cda-394a-44e8-b00e-ee330b9051c0
NotebookCard("https://ricardo-luis.github.io/me-2/Separ.Shunt.GEN.html")

# ╔═╡ f7821a8b-970f-4ab2-807e-05cb5d0304ee
NotebookCard("https://ricardo-luis.github.io/me-2/Compound.GEN.html")

# ╔═╡ 7d3b4efe-fe0b-4496-b16a-439dc1f84638
NotebookCard("https://ricardo-luis.github.io/me-2/Parallel.GEN.html")

# ╔═╡ f33737fc-a926-454a-9d74-bf61b9529e2b
NotebookCard("https://ricardo-luis.github.io/me-2/DCmotors.html")

# ╔═╡ ef1fe96b-efc1-4172-bb6f-9b7739b22382
NotebookCard("https://ricardo-luis.github.io/me-2/back2backlab.html")

# ╔═╡ 034fb377-ce0e-4c8d-b038-1ef84b5f0aaa
NotebookCard("https://ricardo-luis.github.io/me-2/SeriesMotor.html")

# ╔═╡ 37ecb88b-e91a-4bb2-aeae-94c3cd3dec62
NotebookCard("https://ricardo-luis.github.io/me-2/Test.DCmachines.html")

# ╔═╡ ef201862-d8f8-4dff-bea3-4063ea029d81


# ╔═╡ 680b3695-db21-41b7-afc1-ba665bc76d5d
NotebookCard("https://ricardo-luis.github.io/me-2/StandAloneSynGen.html")

# ╔═╡ b3f9eb75-5cab-4fb4-9e25-2b3be1b5df99
NotebookCard("https://ricardo-luis.github.io/me-2/CurvesSynGen.html")

# ╔═╡ e06ae726-d38e-4841-80d5-7200f37da8f8
NotebookCard("https://ricardo-luis.github.io/me-2/Synchro.html")

# ╔═╡ ad768a4f-c5d3-4cd8-b443-9b430e2faaf9
NotebookCard("https://ricardo-luis.github.io/me-2/Vcurves.html")

# ╔═╡ 7865e7ca-4fef-4cf0-b3b9-dbc1f25d0972
NotebookCard("https://ricardo-luis.github.io/me-2/ParallelSynAlt.html")

# ╔═╡ cf92e34b-076f-4aa7-bd11-0ab4f5364233
NotebookCard("https://ricardo-luis.github.io/me-2/SalientPoleSyncMotor.html")

# ╔═╡ 4c005dfd-bc41-4721-becf-9b3d6ffd7f21
NotebookCard("https://ricardo-luis.github.io/me-2/Test.ACmachines.html")

# ╔═╡ 0bfebd14-9929-478e-8521-dc3c610e8304


# ╔═╡ 2d68bd77-e483-441b-b2cc-d4e69f684fd5
NotebookCard("https://ricardo-luis.github.io/me-2/EqualArea.html")

# ╔═╡ 20b341b4-341f-465c-9709-afa732072611
NotebookCard("https://ricardo-luis.github.io/me-2/SCsynAlt.html")

# ╔═╡ f3769341-6dcd-4332-a0a0-0cf79205f627


# ╔═╡ 0823c4d6-bf8a-4bb5-9719-385f8fe90684
md"""
# Instalação de *software*
"""

# ╔═╡ 93b1f79d-2ab4-48ad-9eff-0aea5b6a1505


# ╔═╡ ff1ebc33-1a81-470b-8044-d09a0faec8e6
md"""
## Pluto.jl
Siga as instruções presentes no *website* do [`Pluto.jl`](https://plutojl.org/#install).
De forma sintética, os passos são os seguintes:

- Para instalar o ambiente de desenvolvimento `Pluto.jl` (apenas na primeira vez), execute na linha de comando do `Julia`:
"""

# ╔═╡ a078a168-b48b-46bf-b1a6-6b106616c586
md"""
	import Pkg; Pkg.add("Pluto")
"""

# ╔═╡ 8e883eba-aed5-4d0d-8846-e440a9f6ee4f
md"""
- Para abrir o ambiente de desenvolvimento `Pluto.jl`, seja para executar ou criar um *notebook*, escreva e execute na linha de comando do `Julia`:
"""

# ╔═╡ e77f2489-a0e5-4aeb-a577-e86c353fdf0c
md"""
	import Pluto; Pluto.run()
"""

# ╔═╡ 33ee713c-2142-47b7-8bca-691c00ca4db4


# ╔═╡ 69cefea4-fcc2-4f74-ad6f-4366de284bf7
md"""
# Julia

## Introdução
[`Julia`](https://en.wikipedia.org/wiki/Julia_(programming_language)) é uma linguagem de programação de [alto nível](https://en.wikipedia.org/wiki/High-level_programming_language), [dinâmica](https://en.wikipedia.org/wiki/Dynamic_programming_language) e de elevado desempenho, lançada em 2012 como solução multiplataforma e de código aberto para [computação científica](https://pt.wikipedia.org/wiki/Computa%C3%A7%C3%A3o_cient%C3%ADfica). Apresenta ótimas características para a construção de modelos matemáticos e de técnicas de simulação numérica, permitindo analisar e resolver problemas científicos e de engenharia através do computador.


## "*Time to first plot*"
`Julia` é uma linguagem compilada *just-in-time*. Isso significa que o compilador irá gerar código binário conforme necessário. Assim, quando abrir/executar o *notebook* pela primeira vez, verificará que tem de aguardar algum tempo pela compilação do código `Julia`, dependendo da complexidade do mesmo e da capacidade de processamento do seu computador. Por exemplo, a biblioteca `Plots.jl` para realização de gráficos tem uma dimensão considerável e exige tempo de compilação. Esta latência na compilação de um programa `Julia` é conhecida por "**_time to first plot_**", que teve melhorias significativas nas versões [1.6](https://lwn.net/Articles/856819/), [1.9](https://lwn.net/Articles/933019/) e [1.10](https://lwn.net/Articles/958337/) do `Julia`. Após a primeira execução, apenas as alterações que realize (no código, nos dados, por interação) serão compiladas, pelo que verificará, a partir daí, o [elevado desempenho](https://julialang.org/benchmarks/) da linguagem `Julia`.

Assim, como sugestão, após abrir um dos *notebooks* de Máquinas Elétricas II no seu Julia/Pluto, pode fazer uma primeira leitura desse *notebook* na versão estática do mesmo, disponibilizada neste *website*, até a primeira compilação/execução terminar, para então depois poder utilizá-lo.
"""

# ╔═╡ ae95b75a-0d10-4fd2-afe6-4d7e36448fe6


# ╔═╡ bee54122-c768-4232-be50-4a35b365dd0e

details("Informação complementar",

		md"""
## Informação complementar

- Jeff Bezanson, Stefan Karpinski, Viral B. Shah, Alan Edelman, [Why We Created Julia](https://julialang.org/blog/2012/02/why-we-created-julia/), Massachusetts Institute of Technology, Feb. 2012;

- Gabriel Maistre, [10 Reasons Why You Should Learn Julia](https://blog.goodaudience.com/10-reasons-why-you-should-learn-julia-d786ac29c6ca), artigo de opinião, Good Audience, Sept. 2018;

- Lee Phillips, [An introduction to the Julia language, part 1](https://lwn.net/Articles/763626/), LWN.net, Aug. 2018;

- Lee Phillips, [An introduction to the Julia language, part 2](https://lwn.net/Articles/764001/), LWN.net, Sept. 2018;

- Toby Driscoll, [Matlab vs. Julia vs. Python](https://tobydriscoll.net/post/matlab-vs.-julia-vs.-python/), artigo de opinião, June 2019;

- Bekhruz Tuychiev, [The Rise of the Julia Programming Language  — Is it Worth Learning in 2023?](https://www.datacamp.com/blog/the-rise-of-julia-is-it-worth-learning-in-2022), artigo de opinião, DataCamp, May 2023;

- William F Godoy, [Julia's Value Proposition for Better Scientific Software](https://bssw.io/blog_posts/julia-s-value-proposition-for-better-scientific-software), artigo de opinião, Better Scientific Software, Apr., 2023;

- João Pereira, Mario Siqueira, [Linguagem de programação JULIA: uma alternativa open source e de alto desempenho ao MATLAB](https://periodicos.ifpb.edu.br/index.php/principia/article/view/1345/661), Revista principia - divulgação científica e tecnológica do IFPB, N.º 34, p. 132-140, 2017;

- Abel Soares Siqueira, Gustavo Sarturi, João Okimoto, Kally Chung, [Introdução à programação em Julia](https://juliaintro.github.io/JuliaIntroBR.jl/), tradução do livro de: Allen Downey, Ben Lauwens, [Think Julia: How to Think Like a Computer Scientist](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html), O’Reilly Media, 2018;

- Raimundo Filho, Marina Miranda, Millena Rocha, André Nascimento, [Introdução a linguagem de programação Julia](https://www.edufma.ufma.br/wp-content/uploads/woocommerce_uploads/2023/05/Introdu%C3%A7%C3%A3o-a-linguagem-de-programa%C3%A7%C3%A3o-Julia.pdf),  EDFUMA - Editora da Universidade Federal do Maranhão, São Luís, Brasil, 2023.
	"""
)

# ╔═╡ 7e966db6-ca39-4f66-9ab1-bdc088591608


# ╔═╡ a99a1360-b179-4080-bdbe-b58217597d7e
md"""
# Pluto.jl

## Introdução

Um *notebook* computacional é uma ferramenta amplamente utilizada em computação científica que combina código, texto e visualizações num ambiente interativo. Baseado nos conceitos de [*literate programming*](https://en.wikipedia.org/wiki/Literate_programming) e ciência reproduzível, permite documentar e partilhar análises de forma clara e transparente, como são exemplo os sistemas de *notebooks* existentes para a área de [ciência de dados](https://datasciencenotebook.org/). No contexto de estudo, os *notebooks* servem como complemento aos materiais tradicionais (livros, apontamentos, etc.), oferecendo um espaço para experimentação e exploração prática. O `Pluto.jl` é um ambiente de *notebook* desenvolvido especificamente para `Julia`, proporcionando uma experiência interativa e reativa ideal para aprendizagem e investigação.

O [`Pluto.jl`](https://plutojl.org/) é uma biblioteca `Julia` que proporciona um ambiente de desenvolvimento integrado para a criação de documentos computacionais interativos (*notebooks*).
Utilizando um navegador *web* (recomendado: Mozilla Firefox ou Google Chrome), o `Pluto.jl` permite combinar código `Julia`, resultados computacionais, texto explicativo, expressões matemáticas, gráficos, imagens, etc., de forma interligada. Esta abordagem facilita o processo de ensino-aprendizagem, oferecendo uma experiência interativa ao utilizador.

## Reatividade, reprodutibilidade e interatividade
Os *notebooks* Pluto são reativos, pois a atualização de uma parte do código reexecuta automaticamente todas as partes afetadas por essa alteração. 
Ou seja, o `Pluto.jl` reconhece as dependências entre as células, nos segmentos de código `Julia`. Por conseguinte, sempre que uma célula é alterada, todas as células dependentes são automaticamente atualizadas (como numa folha de cálculo: MS Excel, Google Sheets, ...). Assim, os resultados são recalculados em tempo real, permitindo ao utilizador a exploração dinâmica dos conceitos de forma interativa.

Os *notebooks* Pluto são reproduzíveis, pois configuram automaticamente as dependências necessárias. O `Pluto.jl` regista as bibliotecas usadas no *notebook* e configura o ambiente de execução, assegurando a qualquer utilizador as mesmas condições computacionais. Esta funcionalidade elimina o problema comum de "funciona no meu computador", permitindo uma colaboração mais eficiente e resultados consistentes entre diferentes computadores.

O `Pluto.jl` disponibiliza suporte nativo para *widgets* interativos, como *sliders*, caixas de seleção e campos de introdução de texto, que podem ser associados a variáveis `Julia` através do comando `@bind`. Desta forma, o utilizador pode manipular parâmetros e visualizar de imediato os resultados dessas alterações no código e nas visualizações, sem necessidade de reiniciar ou executar várias células manualmente, tornando a experiência mais fluida e facilitando a criação de *dashboards* e aplicações científicas interativas.


## *Notebooks* em ME II
A escolha do `Pluto.jl` como ambiente de programação reativo para `Julia`, para a elaboração de **_Notebooks_ Computacionais Aplicados a Máquinas Elétricas II**, possibilita a implementação de boas práticas de [Ciência Aberta](https://www.ciencia-aberta.pt/). O `Julia` com o `Pluto.jl` permitem disponibilizar [recursos educacionais abertos](https://en.wikipedia.org/wiki/Open_educational_resources), através da realização de materiais de ensino-aprendizagem. Também no âmbito da investigação e desenvolvimento, estas ferramentas permitem aplicar os princípios [FAIR](https://openscience.eu/):

$$\begin{aligned}
&\text{\textbf{F}indable} \\
&\text{\textbf{A}ccessible} \\
&\text{\textbf{I}nteroperable} \\
&\text{\textbf{R}eusable}
\end{aligned}$$

Assim, os *notebooks* com Julia/Pluto podem fomentar a transparência, reprodutibilidade, reutilização e inovação em ciência/engenharia.
"""

# ╔═╡ 1f41786c-01a2-4b48-9f13-937f7d6f75bf
details("Informação complementar",
md"""
## Informação complementar

- Fons van der Plas, Mikołaj Bochenski, [Interactive notebooks Pluto.jl](https://youtu.be/IAF8DjrQSSk), vídeo de apresentação do Pluto, conferência JuliaCon 2020. Duração: 24min;

- Fons van der Plas, [Pluto.jl — one year later](https://youtu.be/HiI4jgDyDhY), vídeo da conferência JuliaCon 2021. Duração: 27min;

- Fons van der Plas, [Pluto.jl – reactive and reproducible notebooks for Julia](https://www.youtube.com/watch?v=Rg3r3gG4nQo), vídeo de apresentação do Pluto, conferência JupyterCon 2023. Duração: 29min;

- Connor Burns, [A Guide to Building Reactive Notebooks for Scientific Computing With Julia and Pluto.jl](https://medium.com/swlh/a-guide-to-building-reactive-notebooks-for-scientific-computing-with-julia-and-pluto-jl-1a2c0c455d51), artigo de opinião, Medium, Dec. 2020;

- Lee Phillips, [An introduction to Pluto](https://lwn.net/Articles/835930/), artigo de opinião, LWN.net, Nov. 2020.
"""
)

# ╔═╡ 79b4d3c8-4867-499b-8aec-7fb2f84f419e


# ╔═╡ 16d500be-59b5-4d8e-b77e-f40a9d3dd231
md"""
# Guia rápido Julia & Pluto.jl

**Materiais de apoio** — Documentação, exemplos práticos, bibliotecas e ferramentas para programação científica em **`Julia`** e criação de notebooks interativos em **`Pluto.jl`**.
"""

# ╔═╡ 7ab32d01-ea8f-4a3c-9ded-fed8f42ac4fe
details("Julia: zero to hero",
	md"""
## Julia: _zero to hero_

- Jeff Delaney, [Julia in 100 Seconds](https://www.youtube.com/watch?v=JYs_94znYy0), Fireship, YouTube, May 2022

- [Fastrack to Julia](https://juliadocs.github.io/Julia-Cheat-Sheet/) cheatsheet

- [Julia By Example](https://juliabyexample.helpmanual.io/)

- [🎈 Julia docs with Pluto.jl](https://julia-docs-pluto.netlify.app/)

- [MATLAB-Julia-Python](https://cheatsheets.quantecon.org/) comparative cheatsheet by [QuantEcon group](https://quantecon.org) 
				
- [MATLAB to Julia online converter](https://lakras.github.io/matlab-to-julia/)

- [CodeConvert.AI - Convert code with a click of a button](https://www.codeconvert.ai/)

- 🎈 Rémi Vezy, [Julia course: from total beginner to power user](https://vezy.github.io/julia_course/)


### Julia *Packages*

- [Julia Packages](https://juliapackages.com/packages?sort=stars)

- Lee Phillips, [Digging into Julia's package system](https://lwn.net/Articles/871490/), LWN.net, Oct. 2021.

- Alejandra Ramirez, [Practical guide: how to contribute to open source Julia projects](https://github.com/MA-Ramirez/BlogPosts/blob/main/1_PracticalGuide.md), GitHub BlogPosts, Mar. 2023.

"""
)

# ╔═╡ 5bd4a301-45c5-4829-96fd-027affe65cbd
details("Pluto.jl: ferramentas e recursos",
md"""
## Pluto.jl: ferramentas e recursos

- [Basic Commands in Pluto.jl](https://github.com/fonsp/Pluto.jl/wiki/%F0%9F%94%8E-Basic-Commands-in-Pluto)

- Add interactivity to your notebook with PlutoUI.jl:

  - [PlutoUI.jl documentation](https://docs.juliahub.com/PlutoUI/abXFp/0.7.59/))
    
  - [🎈 PlutoUI sample notebook](https://featured.plutojl.org/basic/plutoui.jl)
 
  - doggo dot jl, [How to Create Engaging Interactive Reactive Notebooks using PlutoUI](https://www.youtube.com/watch?v=nkyvN7PXQZc), YouTube, Oct. 2022. Duration: 24min.
 
  - Abel Siqueira, [Explorando notebooks Pluto.jl - Tutoriais de Julia em Português](https://www.youtube.com/watch?v=ZnF27xxlcD8), YouTube, Maio 2021. Duração: 33min.


### Texto e equações 

- [Markdown Guide](https://www.markdownguide.org/)

- [Unicode characters](https://docs.julialang.org/en/v1/manual/unicode-input/)

- PlutoTeachingTools.jl: [🎈 example notebook](https://juliapluto.github.io/PlutoTeachingTools.jl/example.html). This package provides several functions that are useful in Pluto notebooks used for teaching and making tutorials

- LaTeX:

    - [List of LaTeX mathematical symbols](https://oeis.org/wiki/List_of_LaTeX_mathematical_symbols)
    
    - [Online equation editor using LaTeX markup](https://editor.codecogs.com)

- doggo dot jl, [How to Use Markdown and LaTeX in Pluto Notebooks](https://www.youtube.com/watch?v=YahByfBTnCc&list=PLhQ2JMBcfAsjeC10lx_2zDlFUMkBUTyyO&index=2), YouTube, Sep. 2022. Duration: 25min.


### Tabelas

- [Online Markdown tables generator](https://www.tablesgenerator.com/markdown_tables)

- [Pretty Tables.jl](https://ronisbr.github.io/PrettyTables.jl/stable/) documentation. This package has the purpose to print data in matrices in a human-readable format


### Gráficos, desenhos, diagramas, ...

- Christopher Rackauckas, [Summary of Julia Plotting Packages](http://www.stochasticlifestyle.com/summary-of-julia-plotting-packages/), Stochastic Lifestyle blog, Jun. 2023.

- [🎈 Notebooks for the examples in the book](https://packtpublishing.github.io/Interactive-Visualization-and-Plotting-with-Julia/): Diego Javier Zea, Interactive Visualization and Plotting with Julia, Packt Publishing, 2022.  

- Tecnhical drawing, [draw.io](https://app.diagrams.net/)

- Whiteboard for sketching/hand-draw, [tldraw](https://www.tldraw.com/)

- [🎈 ShortCodes.jl](https://raw.githack.com/hellemo/ShortCodes.jl/main/examples/static-demo.html): Simple embedding for Pluto notebooks

\

!!! tip "Nota:"
	O símbolo 🎈 assinala a presença de *notebook*(*s*) associados. 
		
"""
)

# ╔═╡ ef240421-67ee-43bc-83cb-b92bc64c2bbe


# ╔═╡ 1af310d4-12f0-4895-876c-eceed6b6fba5
md"""
# Termos de Utilização

## Condições de Licença
O material publicado neste *website* e no respetivo repositório do GitHub está licenciado da seguinte forma:

- Os segmentos de código `Julia` dos *notebooks* são disponibilizados sob a [Licença MIT](https://tldrlegal.com/license/mit-license);
- O conteúdo explicativo e visual dos *notebooks* é partilhado sob a [Licença Creative Commons Atribuição-CompartilhaIgual 4.0 Internacional](https://creativecommons.org/licenses/by-sa/4.0/deed.pt) (CC BY-SA 4.0).

As suas [questões](https://github.com/Ricardo-Luis/me-2/issues) e/ou [sugestões de melhoria](https://github.com/Ricardo-Luis/me-2/pulls) sobre o(s) *notebook*(*s*) são bem-vindas.


## Sobre o Autor
 $\textcopyright$ 2022-2025 Ricardo Luís 

[**Ricardo Luís**](https://www.isel.pt/docentes/ricardo-jorge-ferreira-luis)\
Professor Adjunto, PhD

**E-mail:** [ricardo.luis@isel.pt](mailto:ricardo.luis@isel.pt)

**Endereço postal:**

> ISEL -- Instituto Superior de Engenharia de Lisboa\
> DEEEA \\ Lab. de Máquinas Elétricas\
> Rua Conselheiro Emídio Navarro, 1\
> 1959-007 Lisboa, Portugal


## Como citar este trabalho
Para qualquer reutilização ou citação dos *notebooks* ou dos seus resultados disponibilizados neste *website*, seja em trabalhos académicos, publicações, materiais educativos, projetos ou outros contextos, utilize, por favor, a seguinte referência:

	Luís, Ricardo (2025). Notebooks Computacionais Aplicados a Máquinas Elétricas II. Instituto Superior de Engenharia de Lisboa, Licenciatura em Engenharia Eletrotécnica. Disponível em: https://ricardo-luis.github.io/me-2/
"""

# ╔═╡ 329f957f-5031-4da9-93a8-2c6acd87ed76


# ╔═╡ a5004d56-6b46-49b9-bf7a-35d0a2749e6d
md"""
# Agradecimentos / Acknowledgements

Agradeço aos amigos e colegas do Grupo Disciplinar de Máquinas Elétricas do ISEL-DEEEA, pelas discussões e ideias que contribuem para a conceção e desenvolvimento destes documentos computacionais, como material de apoio ao ensino-aprendizagem da unidade curricular de Máquinas Elétricas II.

Um reconhecimento especial aos criadores do `Pluto.jl`, Fons van der Plas e Mikołaj Bochenski, bem como a toda a equipa de contribuidores. A característica reativa do seu ambiente de *notebooks* para a linguagem de programação científica `Julia` possibilitou a adopção de *notebooks* computacionais para o ensino e investigação em máquinas eléctricas.

Expresso também o meu apreço à comunidade `Julia` e aos programadores das bibliotecas utilizadas nestes notebooks, cujo trabalho colaborativo enriquece constantemente as possibilidades educativas desta plataforma.

---

I thank my friends and colleagues from the Electrical Machines Teaching Group at ISEL-DEEEA for the discussions and ideas that contributed to the conception and development of these computational documents as support material for the teaching and learning the Electric Machinery II course.

Special acknowledgment goes to the creators of `Pluto.jl`, Fons van der Plas and Mikołaj Bochenski, as well as the entire team of contributors. The reactive nature of their notebook environment for the `Julia` scientific programming language made it possible to adopt this type of computational notebook for teaching and research in electrical machines.

I also express my appreciation to the `Julia` community and the developers of the packages used in these notebooks, whose collaborative work constantly enriches the educational possibilities of this platform.
"""

# ╔═╡ cc5006d1-c8fb-4d34-863a-f1e5e5ce3147
HTML("""
<div style="text-align: right; font-style: italic; margin-top: 10px;">
Ricardo Luís
</div>
""")

# ╔═╡ eaf85eed-ae13-42f2-ba95-0bd2024394e2
# Define alinhamento justificado para distribuir uniformemente o texto entre as margens + fonte principal:
html"""<style>
pluto-output p {
    text-align: justify;
}
pluto-output {
    font-family: system-ui;
	font-size:  100%
}
</style>
"""

# ╔═╡ 72c8086a-c513-4245-a00a-0a5a9da78ffb
md"""
# Configuração do *notebook*
"""

# ╔═╡ 4c204456-666b-492f-b92e-45a591a95cda
md"""
Esta secção apresenta a configuração técnica deste *notebook*, incluindo as bibliotecas `Julia` carregadas automaticamente pelo `Pluto.jl`.
"""

# ╔═╡ 8711b954-5490-4ade-acfe-ec1fa614bfc9
begin
	version=VERSION
	md"""
*Nobebook* desenvolvido em `Julia` versão $(version).
	"""
end

# ╔═╡ f83478f1-ef46-4441-9f4f-fdac036563c9
TableOfContents(title="Índice", depth=2)  # Table of Contents from Markdown headers

# ╔═╡ e785e52d-3662-4e9f-a932-b01dac732421
#= 
Função para alterar automaticamente logotipos utilizados no notebook, dependendo se o browser está ou não em "dark mode".
A função integra ainda a possibilidade de cada imagem funcionar como link para uma nova aba do browser.
Nota: obtido com ajuda de AI (deepseek)
=#

function logo_adaptativo(logos::Dict, links::Dict=Dict(); default_logo=first(keys(logos)))
    # Configuração inicial
    config = logos[default_logo]
    light = config.light
    dark = config.dark
    height = config.height
    url = get(links, default_logo, nothing)
    
    # Serialização segura dos dados
    logos_js = join([
        "\"$k\":{\"light\":\"$(v.light)\",\"dark\":\"$(v.dark)\",\"height\":$(v.height)}" 
        for (k,v) in logos
    ], ",")
    
    links_js = join(["\"$k\":\"$v\"" for (k,v) in links], ",")
    
    # HTML/JS com template seguro
    return HTML("""
    <script>
    (function() {
        const container = document.currentScript.parentElement;
        const logos = {$logos_js};
        const links = {$links_js};
        
        const img = document.createElement('img');
        img.height = $(height);
        img.style.transition = 'opacity 0.3s';
        $(url !== nothing ? "img.style.cursor = 'pointer';" : "")
        
        function update() {
            const isDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            const logoName = img.getAttribute('data-logo') || '$default_logo';
            const logo = logos[logoName];
            
            img.src = isDark ? logo.dark : logo.light;
            img.height = logo.height;
            img.style.opacity = 0;
            setTimeout(() => img.style.opacity = 1, 100);
        }
        
        $(url !== nothing ? "img.onclick = () => window.open(links[img.getAttribute('data-logo') || '$default_logo'], '_blank');" : "")
        
        window.matchMedia('(prefers-color-scheme: dark)')
             .addEventListener('change', update);
        
        update();
        container.appendChild(img);
    })();
    </script>
    """)
end;

# ╔═╡ c6d64e49-3d58-41a6-bdd3-62cddc7e86d6
begin
	# Configuração dos logos
	my_logos = Dict(
	    "isel" => (
	        light="https://github.com/Ricardo-Luis/me-2/blob/main/images/ISEL-logo.png?raw=true",
	        dark="https://github.com/Ricardo-Luis/me-2/blob/main/images/ISEL-logo-dark.png?raw=true",
	        height=70
	    ),
	    "julia" => (
	        light="https://github.com/Ricardo-Luis/me-2/blob/main/images/julia.svg?raw=true",
	        dark="https://github.com/Ricardo-Luis/me-2/blob/main/images/julia_dark.svg?raw=true",
	        height=45
	    ),
		"pluto" => (
	        light="https://github.com/Ricardo-Luis/me-2/blob/main/images/pluto.svg?raw=true",
	        dark="https://github.com/Ricardo-Luis/me-2/blob/main/images/pluto.svg?raw=true",
	        height=35
		),
		"repl" => (
	        light="https://github.com/Ricardo-Luis/me-2/blob/main/images/repl.png?raw=true",
	        dark="https://github.com/Ricardo-Luis/me-2/blob/main/images/repl_dark.png?raw=true",
	        height=300
		),
		"welcome" => (
	        light="https://github.com/Ricardo-Luis/me-2/blob/main/images/welcome_pluto.png?raw=true",
	        dark="https://github.com/Ricardo-Luis/me-2/blob/main/images/welcome_pluto_dark.png?raw=true",
	        height=300
		),
		"QRcode" => (
	        light="https://github.com/Ricardo-Luis/me-2/blob/main/images/card/qr-code.svg?raw=true",
	        dark="https://github.com/Ricardo-Luis/me-2/blob/main/images/card/qr-code.svg?raw=true",
	        height=120
		)
	)
	
	# Links correspondentes
	my_links = Dict(
	    "isel" => "https://www.isel.pt",
	    "julia" => "https://julialang.org",
		"pluto" => "https://plutojl.org",
		"QRcode"=> "https://ricardo-luis.github.io/me-2/#Notebooks-ME-II"
	)
end;

# ╔═╡ c4c3c88d-e13f-4782-9131-eb0d70b5277d
TwoColumnWideLeft(logo_adaptativo(my_logos, my_links, default_logo="isel"),
    md"""
    $$\begin{align}
    \\[-5mm]
    \small{\textsf{Licenciatura em Engenharia Eletrotécnica}} \\
    \href{https://www.isel.pt/sites/default/files/FUC_202425_3894.pdf}{\textcolor{Bittersweet}{\small{\textbf{Máquinas Elétricas II}}}}
    \end{align}$$
    """
)

# ╔═╡ 5fa1359a-5e2b-4d95-a09c-e32157b55a29
md"""
## Julia
Para instalar a linguagem de computação científica `Julia`, pode recorrer a um dos seguintes métodos:

### Linha de comando
A forma mais simples de instalar `Julia` no seu computador é usar o `juliaup`, um pequeno programa que instala automaticamente a versão mais recente de `Julia` e facilita a sua atualização.

Para tal, aceda à página *web* de `Julia`, [(https://julialang.org/)](https://julialang.org/), e clique em ["Install"](https://julialang.org/install/).

A página de instalação apresentada deteta o sistema operativo do seu computador e apresenta, numa caixa cinzenta, uma linha de comando para instalação do `juliaup`. Copie, cole e execute essa instrução no [terminal do computador](https://hub.asimov.academy/tutorial/como-utilizar-o-terminal/).

### *Download* manual
Se por algum motivo não foi bem-sucedido com o instalador `juliaup`, pode, em alternativa, fazer uma instalação manual do *software* `Julia`, optando pela "**_Current stable release_**" adequada ao seu computador/sistema operativo. Por favor, consulte: [*Download* Julia](https://julialang.org/downloads/)

### Verificar a instalação do `Julia`
Após a instalação, certifique-se de que consegue executar o `Julia`. Em alguns sistemas operativos, isto significa abrir o programa "**Julia 1.11.x**"; noutros, significa executar o comando `julia` no terminal.

Após abrir o `Julia`, teste a instalação executando, por exemplo:

	julia> 1+1

\
Ou seja:  

$(logo_adaptativo(my_logos, my_links, default_logo="repl"))
"""

# ╔═╡ 82dbfe15-8e45-4348-8845-424e70f0deeb
md"""
- No seu navegador *web* aparecerá uma página de boas-vindas do `Pluto.jl`:

$(logo_adaptativo(my_logos, my_links, default_logo="welcome"))
"""

# ╔═╡ 7ccff6b8-1f59-4965-a9e9-6c22327963bd
# cor adoptada para "ME II" (do LaTEX: BitterSweet)
function ME2color(s::String)
	HTML("<span style='color: hsl(19.88deg, 78.6%, 42.16%);'> $(s) <span>")
end;

# ╔═╡ 054f60fc-9f3b-49c7-8f0e-c94dd6595000
md"""
**$(html"<p><center style='font-size:19px;font-family:monospace'>Notebooks Computacionais Aplicados a Máquinas Elétricas II</center></p>")** 

|     |     |     |
| :-: | :-: | :-: |
| $(ME2color("Linguagem de computação científica")) | $(ME2color("Ambiente de desenvolvimento integrado")) | $(ME2color("Biblioteca de notebooks")) |
| $(logo_adaptativo(my_logos, my_links, default_logo="julia")) | $(logo_adaptativo(my_logos, my_links, default_logo="pluto")) | $(logo_adaptativo(my_logos, my_links, default_logo="QRcode")) |
"""

# ╔═╡ 1d27f002-0a8f-4326-a1ed-12036aa9c8a3
md"""
## $(ME2color("Fundamentos"))
"""

# ╔═╡ 93d4db20-7c76-4396-82ee-15f7fdd37b8a
md"""
## $(ME2color("Máquina Elétrica de Corrente Contínua"))
"""

# ╔═╡ 3ae99ca8-e11d-4186-8d0a-80570dc1ac9d
md"""
## $(ME2color("Máquina Elétrica Síncrona Trifásica"))
"""

# ╔═╡ 4d1504da-3b03-4c0f-9582-22aa552b21ea
md"""
## $(ME2color("Transitórios de Máquinas Elétricas"))
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoTeachingTools = "~0.2.15"
PlutoUI = "~0.7.68"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "bb49baa68f0cfedf1cca0fcc8cfa7dcdf5b33099"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "5ac098a7c8660e217ffac31dc2af0964a8c3182a"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "2.0.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.Compiler]]
git-tree-sha1 = "382d79bfe72a406294faca39ef0c3cef6e6ce1f1"
uuid = "807dbc54-b67e-4c79-8afb-eafe4df6f2e1"
version = "0.1.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "e09121f4c523d8d8d9226acbed9cb66df515fcf2"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.10.4"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "4f34eaabe49ecb3fb0d58d6015e32fd31a733199"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.8"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoweredCodeUtils]]
deps = ["CodeTracking", "Compiler", "JuliaInterpreter"]
git-tree-sha1 = "73b98709ad811a6f81d84e105f4f695c229385ba"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.4.3"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "5d9ab1a4faf25a62bb9d07ef0003396ac258ef1c"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.15"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ec9e63bd098c50e4ad28e7cb95ca7a4860603298"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.68"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Revise]]
deps = ["CodeTracking", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "20ccb7e2501e9da93fe8450d01aeabf16a5f0c82"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.8.1"

    [deps.Revise.extensions]
    DistributedExt = "Distributed"

    [deps.Revise.weakdeps]
    Distributed = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─c4c3c88d-e13f-4782-9131-eb0d70b5277d
# ╟─2e32c42e-7736-43e0-bff0-966cbbadc732
# ╟─054f60fc-9f3b-49c7-8f0e-c94dd6595000
# ╟─f0ff75df-7efd-4628-830c-b4af68ac09d4
# ╟─d4933445-95c9-4f86-a832-95278e8aa34c
# ╟─1eb0fa23-13f7-4dd2-b4b8-b8a6d802d90c
# ╟─659cda0d-61f1-4e65-b541-9d5e6c69bab2
# ╟─1d27f002-0a8f-4326-a1ed-12036aa9c8a3
# ╟─ca020f4c-e830-4eb1-8284-308551465919
# ╟─3851b901-0f6f-4771-8adb-7820a7b60465
# ╟─a80136eb-b0fa-4062-8889-2c90976369a3
# ╟─1f3385c5-e2cb-4b36-af2c-3ca16e7dc4f1
# ╟─93d4db20-7c76-4396-82ee-15f7fdd37b8a
# ╟─379a42a7-8f18-42de-bdc0-5601561196dd
# ╟─fc130cda-394a-44e8-b00e-ee330b9051c0
# ╟─f7821a8b-970f-4ab2-807e-05cb5d0304ee
# ╟─7d3b4efe-fe0b-4496-b16a-439dc1f84638
# ╟─f33737fc-a926-454a-9d74-bf61b9529e2b
# ╟─ef1fe96b-efc1-4172-bb6f-9b7739b22382
# ╟─034fb377-ce0e-4c8d-b038-1ef84b5f0aaa
# ╟─37ecb88b-e91a-4bb2-aeae-94c3cd3dec62
# ╟─ef201862-d8f8-4dff-bea3-4063ea029d81
# ╟─3ae99ca8-e11d-4186-8d0a-80570dc1ac9d
# ╟─680b3695-db21-41b7-afc1-ba665bc76d5d
# ╟─b3f9eb75-5cab-4fb4-9e25-2b3be1b5df99
# ╟─e06ae726-d38e-4841-80d5-7200f37da8f8
# ╟─ad768a4f-c5d3-4cd8-b443-9b430e2faaf9
# ╟─7865e7ca-4fef-4cf0-b3b9-dbc1f25d0972
# ╟─cf92e34b-076f-4aa7-bd11-0ab4f5364233
# ╟─4c005dfd-bc41-4721-becf-9b3d6ffd7f21
# ╟─0bfebd14-9929-478e-8521-dc3c610e8304
# ╟─4d1504da-3b03-4c0f-9582-22aa552b21ea
# ╟─2d68bd77-e483-441b-b2cc-d4e69f684fd5
# ╟─20b341b4-341f-465c-9709-afa732072611
# ╟─f3769341-6dcd-4332-a0a0-0cf79205f627
# ╟─0823c4d6-bf8a-4bb5-9719-385f8fe90684
# ╟─5fa1359a-5e2b-4d95-a09c-e32157b55a29
# ╟─93b1f79d-2ab4-48ad-9eff-0aea5b6a1505
# ╟─ff1ebc33-1a81-470b-8044-d09a0faec8e6
# ╟─a078a168-b48b-46bf-b1a6-6b106616c586
# ╟─8e883eba-aed5-4d0d-8846-e440a9f6ee4f
# ╟─e77f2489-a0e5-4aeb-a577-e86c353fdf0c
# ╟─82dbfe15-8e45-4348-8845-424e70f0deeb
# ╟─33ee713c-2142-47b7-8bca-691c00ca4db4
# ╟─69cefea4-fcc2-4f74-ad6f-4366de284bf7
# ╟─ae95b75a-0d10-4fd2-afe6-4d7e36448fe6
# ╟─bee54122-c768-4232-be50-4a35b365dd0e
# ╟─7e966db6-ca39-4f66-9ab1-bdc088591608
# ╟─a99a1360-b179-4080-bdbe-b58217597d7e
# ╟─1f41786c-01a2-4b48-9f13-937f7d6f75bf
# ╟─79b4d3c8-4867-499b-8aec-7fb2f84f419e
# ╟─16d500be-59b5-4d8e-b77e-f40a9d3dd231
# ╟─7ab32d01-ea8f-4a3c-9ded-fed8f42ac4fe
# ╟─5bd4a301-45c5-4829-96fd-027affe65cbd
# ╟─ef240421-67ee-43bc-83cb-b92bc64c2bbe
# ╟─1af310d4-12f0-4895-876c-eceed6b6fba5
# ╟─329f957f-5031-4da9-93a8-2c6acd87ed76
# ╟─a5004d56-6b46-49b9-bf7a-35d0a2749e6d
# ╟─cc5006d1-c8fb-4d34-863a-f1e5e5ce3147
# ╟─eaf85eed-ae13-42f2-ba95-0bd2024394e2
# ╟─72c8086a-c513-4245-a00a-0a5a9da78ffb
# ╟─4c204456-666b-492f-b92e-45a591a95cda
# ╠═766e42e6-0d19-48ba-b1a5-462708df3ff9
# ╟─8711b954-5490-4ade-acfe-ec1fa614bfc9
# ╠═f83478f1-ef46-4441-9f4f-fdac036563c9
# ╟─e785e52d-3662-4e9f-a932-b01dac732421
# ╟─c6d64e49-3d58-41a6-bdd3-62cddc7e86d6
# ╟─7ccff6b8-1f59-4965-a9e9-6c22327963bd
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
