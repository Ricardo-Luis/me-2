### A Pluto.jl notebook ###
# v0.19.19

using Markdown
using InteractiveUtils

# ╔═╡ 766e42e6-0d19-48ba-b1a5-462708df3ff9
using PlutoUI, PlutoTeachingTools

# ╔═╡ d4933445-95c9-4f86-a832-95278e8aa34c
md"""

**Bem-vindo(a)**, 

Este website disponibiliza a leitura e o acesso a uma coleção de *notebooks* na forma de notas de aula e cálculos de engenharia, de apoio à unidade curricular de Máquinas Elétricas II, lecionada no curso de Licenciatura em Engenharia Eletrotécnica do Instituto Superior de Engenharia de Lisboa.

Os *notebooks* são documentos computacionais que utilizam o navegador web, combinando simultaneamente, o desenvolvimento e os resultados computacionais, com texto, expressões matemáticas, tabelas, imagens, etc., de uma forma interligada e interativa com o utilizador.

Estes *notebooks* são desenvolvidos utilizando o `Pluto.jl` que é um ambiente de programação simples e reativo para a linguagem de computação científica `Julia`.
"""

# ╔═╡ 1eb0fa23-13f7-4dd2-b4b8-b8a6d802d90c


# ╔═╡ 659cda0d-61f1-4e65-b541-9d5e6c69bab2
md"""
# Notebooks de ME II:
👆 Clique nos *links* seguintes para visualizar cada um dos *notebooks*: 
\
**Máquina elétrica de corrente contínua**

- [Gerador: exc. separada vs. shunt, Ex.2](./Separ.Shunt.GEN.Ex2.html)
- [Gerador compound, Ex.4](./Compound.GEN.Ex4.html)
- [Paralelo de geradores, Ex.6](./ParallelGenerators.Ex6.html)
- [Curvas características motores, Ex.7](./DCmotors.Ex7.html)
- [Ensaio back-to-back, Lab.](./back2backlab.html)
- [Motor série, Ex.9](./SeriesMotor.html)
- [Resolução de teste (03/nov/2022)](./Test.DCmachines.html)

\
**Máquina elétrica síncrona trifásica**

- [Alternador em regime isolado, Ex.1](./StandAloneSynGen.html)
- [Alternador, curvas características, Ex.2](./CurvesSynGen.html)
- [Curvas de Mordey](./Vcurves.html)
- [Motor polos salientes, Ex.8](./SalientPoleSyncMotor.html)
- [Critério da igualdade das áreas, Ex.11](./EqualArea.html)
- [Resolução de teste (27/jan/2023)](./Test.ACmachines.html)
"""

# ╔═╡ f3769341-6dcd-4332-a0a0-0cf79205f627


# ╔═╡ 0823c4d6-bf8a-4bb5-9719-385f8fe90684
md"""
# Notebooks reativos

## Instalação de software
"""

# ╔═╡ 5fa1359a-5e2b-4d95-a09c-e32157b55a29


# ╔═╡ 79666f23-855e-4de8-b8b4-3f1c3fa0559c
md"""
### First-time setup: Install `Julia` & `Pluto`

> **Acknowledgement** \\
> This material is taken from _**Computational Thinking**, a live online Julia/Pluto textbook._ [(computationalthinking.mit.edu)](https://computationalthinking.mit.edu)
"""

# ╔═╡ e4b2b337-b6cc-44e6-9aeb-0a206e553bf2


# ╔═╡ b808fbbb-8468-41db-8095-d40fde95dfb5
md"""
#### Step 1: Install `Julia`

Go to [https://julialang.org/downloads](https://julialang.org/downloads) and download the current stable release of `Julia`, using the correct version for your operating system (Linux x86, Mac, Windows, etc).

*Mac users beware!* Do **not** download the ARM/M-series version of `Julia`! It is still experimental and some packages will not work.
"""

# ╔═╡ 21e7517e-b11a-4c8d-a767-7f512257ccf9


# ╔═╡ d27ed498-bac0-4724-976f-59404cd5d878
md"""
#### Step 2: Run `Julia`

After installing, **make sure that you can run `Julia`**. On some systems, this means searching for the "`Julia` 1.7.2" program installed on your computer; in others, it means running the command `julia` in a terminal. Make sure that you can execute `1 + 1`:

![image](https://user-images.githubusercontent.com/6933510/91439734-c573c780-e86d-11ea-8169-0c97a7013e8d.png)

*Make sure that you are able to launch `Julia` and calculate `1+1` before proceeding!*
"""

# ╔═╡ fca14e55-3841-45cc-bb3e-150356724b44


# ╔═╡ fc7938bc-f01a-46bb-b64c-7113cc019d01
md"""
#### Step 3: Install `Pluto.jl`

Next we will install the [**`Pluto` notebook**](https://github.com/fonsp/Pluto.jl/blob/master/README.md) that we will be using during the course. [`Pluto`](https://github.com/fonsp/Pluto.jl) is a Julia _programming environment_ designed for interactivity and quick experiments.

Open the **`Julia` REPL**. This is the command-line interface to `Julia`, similar to the previous screenshot.

Here you type _Julia commands_, and when you press ENTER, it runs, and you see the result.

To install `Pluto`, we want to run a _package manager command_. To switch from _Julia_ mode to _Pkg_ mode, type `]` (closing square bracket) at the `julia>` prompt:

```julia
julia> ]
```

```julia
(@v1.7) pkg>
```


The line turns blue and the prompt changes to `pkg>`, telling you that you are now in _package manager mode_. This mode allows you to do operations on **packages** (also called libraries).

To install `Pluto`, run the following (case sensitive) command to *add* (install) the package to your system by downloading it from the internet.
You should only need to do this *once* for each installation of `Julia`:

```julia
(@v1.7) pkg> add Pluto
```


This might take a couple of minutes, so you can go get yourself a cup of tea!

![image](https://user-images.githubusercontent.com/6933510/91440380-ceb16400-e86e-11ea-9352-d164911774cf.png)

You can now close the terminal.
"""

# ╔═╡ d2fe29e7-5a4b-4844-9ce1-0e2ef6687fdc


# ╔═╡ 93ab033c-e630-4789-8466-5ced9d4053eb
md"""
#### Step 4: Use a modern browser: Mozilla Firefox or Google Chrome
We need a modern browser to view `Pluto` notebooks with. Firefox and Chrome work best.
\
\


### Second time: _Running `Pluto` & opening a notebook_
Repeat the following steps whenever you want to work on a project or homework assignment.
\
"""

# ╔═╡ 03ea77a5-9a90-470f-8c8f-6fff2609f917


# ╔═╡ 25483496-477a-432a-abc9-db637bcd9ed2
md"""
#### Step 1: Start `Pluto`

Start the `Julia` REPL, like you did during the setup. In the REPL, type:


```julia
julia> using Pluto
```

```julia
julia> Pluto.run()
```


![image](https://user-images.githubusercontent.com/6933510/91441094-eb01d080-e86f-11ea-856f-e667fdd9b85c.png)

The terminal tells us to go to `http://localhost:1234/` (or a similar URL). Let's open Firefox or Chrome and type that into the address bar.

![image](https://user-images.githubusercontent.com/6933510/91441391-6a8f9f80-e870-11ea-94d0-4ef91b4e2242.png)

> If you're curious about what a _`Pluto` notebook_ looks like, have a look at the **sample notebooks**. Samples 1, 2 and 6 may be useful for learning some basics of `Julia` programming. 
> 
> If you want to hear the story behind `Pluto`, have a look a the [JuliaCon presentation](https://www.youtube.com/watch?v=IAF8DjrQSSk).

If nothing happens in the browser the first time, close `Julia` and try again. And please let us know!

"""

# ╔═╡ a933967e-0057-48a9-aa14-7220525b57c1


# ╔═╡ 2106627e-fa26-4869-8893-c3113b1ece12
md"""
#### Step 2a: Opening a notebook from the web

This is the main menu - here you can create new notebooks, or open existing ones. Our homework assignments will always be based on a _template notebook_, available in this GitHub repository. To start from a template notebook on the web, you can _paste the URL into the blue box_ and press ENTER.

For example, homework 0 is available [here](/hw0/). Go to this page, and on the top right, click on the button that says "Edit or run this notebook". From these instructions, copy the notebook link, and paste it into the box. Press ENTER, and select OK in the confirmation box.

![image](https://user-images.githubusercontent.com/6933510/91441968-6b750100-e871-11ea-974e-3a6dfd80234a.png)

**The first thing we will want to do is to save the notebook somewhere on our own computer; see below.** 

"""

# ╔═╡ 40c63f7b-db87-4b40-85a2-411e86b23bb6


# ╔═╡ 5a120f0e-e047-4af7-ab2a-179ccfa6557b
md"""
#### Step 2b: Opening an existing notebook file
When you launch `Pluto` for the second time, your recent notebooks will appear in the main menu. You can click on them to continue where you left off.

If you want to run a local notebook file that you have not opened before, then you need to enter its _full path_ into the blue box in the main menu. More on finding full paths in step 3.
"""

# ╔═╡ 2a7f669d-e085-4bd6-8fdb-dd60315a4101


# ╔═╡ a312937f-7b82-42aa-bd00-04e289d154e8
md"""
#### Step 3: Saving a notebook
We first need a folder to save our homework in. Open your file explorer and create one. 

Next, we need to know the _absolute path_ of that folder. Here's how you do that in [Windows](https://www.top-password.com/blog/copy-full-path-of-a-folder-file-in-windows/), [MacOS](https://www.josharcher.uk/code/find-path-to-folder-on-mac/) and [Ubuntu]().

For example, you might have:

- `C:\\Users\\fonsi\\Documents\\18S191_assignments\\` on Windows

- `/Users/fonsi/Documents/18S191_assignments/` on MacOS

- `/home/fonsi/Documents/18S191_assignments/` on Ubuntu

Now that we know the absolute path, go back to your `Pluto` notebook, and at the top of the page, click on _"Save notebook..."_. 

![image](https://user-images.githubusercontent.com/6933510/91444741-77fb5880-e875-11ea-8f6b-02c1c319e7f3.png)

This is where you type the **new path+filename for your notebook**:

![image](https://user-images.githubusercontent.com/6933510/91444565-366aad80-e875-11ea-8ed6-1265ded78f11.png)

Click _Choose_.
"""

# ╔═╡ 3fd8c7df-4aa0-49d6-a8e8-0c383b1b3947


# ╔═╡ 28512235-de44-4d62-9e3b-6e4cd4954a36
md"""
#### Step 4: Sharing a notebook

After working on your notebook (your code is autosaved when you run it), you will find your notebook file in the folder we created in step 3. This the file that you can share with others.

"""

# ╔═╡ f78860b7-b9db-44c5-bdbe-1d97ac7060bb


# ╔═╡ fb8fae23-5360-466f-884a-b6626064a589


# ╔═╡ 0f360a8f-9a77-488d-a050-a95e8af83dfb
md"""
## Notebooks Pluto
"""

# ╔═╡ e66d1b52-c2da-44c6-9dcf-60afbd397ed9
md"""
### Work in progress...
"""

# ╔═╡ 4e5d5c46-6d98-4125-868f-548d28b96511
Foldable("TODO list:",md"""

- sobre notebooks... complemento aos elementos de estudo (não substitui livro, apontamentos da aula, etc...)
- Sobre notebooks em geral?! Ex: [Data Science Notebooks](https://datasciencenotebook.org/)
    - *literate programming*; ciência reproduzível
- como abrir os notebooks:
    - executar um notebook na cloud (Binder) raramente funciona! » Instalar Julia e Pluto (dentro do Julia)
    - fazer download (notebook.jl) ou **copiar URL colocado no topo do notebook: "GitHub URL | notebook" e colar no Pluto na barra de "Open a notebook"**
- Ferramentas utilizadas nos notebooks Pluto:
    - Markdown (texto): qualquer célula pode ser interpretada como texto, premindo no teclado "Ctrl" + "m"
    - LaTeX (equações)... não é necessário saber Latex, Ex: [Online Equation Editor](https://www.codecogs.com/eqnedit.php)
    - [draw.io](https://app.diagrams.net/) (desenhos, esquemas, diagramas), disponíveis para reutilização
    - Julia (cálculo, gráficos); não requer especial conhecimento de programação; sintaxe muito idêntica ao MATLAB/Octave
    - Julia, aceita símbolos Unicode nas expressões de cálculo (grande vantagem, pois torna as expressões de cálculo muito semelhantes às equações escritas de forma matemática), [Unicode Input](https://docs.julialang.org/en/v1/manual/unicode-input/)
    - PlutoUI (interactividade com o utilizador), [How to Create Engaging Interactive Reactive Notebooks using PlutoUI, Pluto and Julia](https://youtu.be/nkyvN7PXQZc), YT vídeo (cerca de 25min.)
- Notebook reactivo: nas parcelas de código, o Pluto reconhece as dependências entre as células. Sempre que uma é alterada, todas as células que desta dependem são automaticamente atualizadas (como no Excel).

""")

# ╔═╡ ea2a84a1-7375-4933-a166-6bbd2eaa51e7


# ╔═╡ 45290d8f-5625-4796-adef-bc89554d827f
md"""
### A linguagem de programação `Julia` 

[`Julia`](https://en.wikipedia.org/wiki/Julia_(programming_language)) é uma linguagem de programação de [alto nível](https://en.wikipedia.org/wiki/High-level_programming_language), [dinâmica](https://en.wikipedia.org/wiki/Dynamic_programming_language) e de elevado desempenho adequada para [computação científica](https://pt.wikipedia.org/wiki/Computa%C3%A7%C3%A3o_cient%C3%ADfica). Apresenta ótimas características para a construção de modelos matemáticos e de técnicas de simulação numérica, permitindo analisar e resolver problemas científicos e de engenharia, através do computador.

`Julia` foi lançada em 2012 mantendo-se como uma linguagem de programação gratuita, multi-plataforma e *open source*.


A escolha do `Pluto.jl` como ambiente de programação reativo para `Julia`, para a elaboração de *notebooks* de apoio a Máquinas Elétricas II, possibilita a implementação de boas práticas de [Ciência Aberta](https://www.ciencia-aberta.pt/). O `Julia` com o `Pluto.jl` permitem disponibilizar [recursos educacionais abertos](https://en.wikipedia.org/wiki/Open_educational_resources), através da realização de materiais de ensino-aprendizagem. Também no âmbito da investigação e desenvolvimento, estas ferramentas permitem aplicar os princípios [FAIR](https://openscience.eu/):

- **F**indable
- **A**ccessible
- **I**nteroperable
- **R**eusable

Assim, os *notebooks* reactivos com `Julia/Pluto` podem fomentar a transparência, reprodutibilidade, reutilização e inovação em ciência/engenharia.
"""

# ╔═╡ 33ee713c-2142-47b7-8bca-691c00ca4db4


# ╔═╡ 80b30983-2eb5-40f2-bbc3-c5a8b68ad8f8
md"""
#### "Time to first plot"

`Julia` é uma linguagem compilada *just-in-time* (JIT). Isso significa que o compilador irá gerar código binário conforme necessário. Assim, quando abrir/executar o *notebook* pela primeira vez, verificará que tem de aguardar algum tempo pela compilação do código `Julia`, dependendo da complexidade do mesmo e da capacidade de processamento do seu computador. Por exemplo, a biblioteca `Plots.jl` para realização de gráficos tem uma dimensão considerável e exige tempo de compilação. Esta latência na compilação de um programa `Julia` é conhecida por ["_time to first plot_"](https://lwn.net/Articles/856819/), que teve melhorias significativas na versão 1.6 do `Julia`. Após a 1ª execução, apenas as alterações que realize (no código, nos dados, por interação) serão compiladas, pelo que verificará, a partir daí o [elevado desempenho](https://julialang.org/benchmarks/) da linguagem `Julia`.

Assim, como sugestão, após abrir um dos *notebooks* de Máquinas Elétricas II no seu `Julia/Pluto`, pode fazer uma primeira leitura desse *notebook* na versão estática do mesmo, disponibilizada neste *website*, até a 1ª compilação/execução terminar, para então depois poder utilizá-lo.

No final de cada *notebook* é indicado o tempo da 1ª compilação, acompanhado das informações sobre a frequência de processamento do CPU e a capacidade de memória RAM do computador em que foi testado, como referência.
"""

# ╔═╡ 1a9de438-3a54-4739-9c70-e501f58f71e6


# ╔═╡ 37f6f655-412c-426d-9505-6bb5b269c612
md"""
## Consulta rápida

- [Fastrack to `Julia`](https://juliadocs.github.io/Julia-Cheat-Sheet/) cheatsheet.
- [MATLAB-`Julia`-Python](https://cheatsheets.quantecon.org/) by [QuantEcon group](https://quantecon.org) comparative cheatsheet
- [Julia By Example](https://juliabyexample.helpmanual.io/)										
- [MATLAB to `Julia` online converter](https://lakras.github.io/matlab-to-julia/)
- [`Julia` Packages](https://juliapackages.com/packages?sort=stars)
- [Basic Commands in `Pluto`](https://github.com/fonsp/Pluto.jl/wiki/%F0%9F%94%8E-Basic-Commands-in-Pluto)
- [Plots.jl cheatsheet](https://github.com/sswatson/cheatsheets/blob/master/plotsjl-cheatsheet.pdf)
- [Markdown Guide](https://www.markdownguide.org/)
"""

# ╔═╡ e7252dec-bd34-4186-b36a-111dea1ba96d
md"""
## Leitura/informação complementar:
\

### Sobre _notebooks_ `Pluto`:

- Fons van der Plas, Mikołaj Bochenski, [Interactive notebooks `Pluto`.jl](https://youtu.be/IAF8DjrQSSk), vídeo de apresentação do `Pluto`, conferência JuliaCon 2020, Duração: 24min.
- Fons van der Plas, [🎈 `Pluto`.jl — one year later](https://youtu.be/HiI4jgDyDhY), vídeo da conferência JuliaCon 2021. Duração: 27min.
- Connor Burns, [A Guide to Building Reactive Notebooks for Scientific Computing With Julia and `Pluto.jl`](https://medium.com/swlh/a-guide-to-building-reactive-notebooks-for-scientific-computing-with-julia-and-pluto-jl-1a2c0c455d51), artigo de opinião, Medium, Dec. 2020.

\

### Sobre programação `Julia`:

- Jeff Bezanson, Stefan Karpinski, Viral B. Shah, Alan Edelman, [Why We Created `Julia`](https://julialang.org/blog/2012/02/why-we-created-julia/), Massachusetts Institute of Technology, Feb. 2012.
- Gabriel Gauci Maistre, [10 Reasons Why You Should Learn `Julia`](https://blog.goodaudience.com/10-reasons-why-you-should-learn-julia-d786ac29c6ca), artigo de opinião, Good Audience, Sep. 2018.
- Abel Soares Siqueira, Gustavo Sarturi, João Okimoto, Kally Chung, [Introdução à programação em `Julia`](https://juliaintro.github.io/JuliaIntroBR.jl/), tradução do livro de: Allen Downey, Ben Lauwens, [Think `Julia`: How to Think Like a Computer Scientist](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html), O’Reilly Media, 2018. 
"""

# ╔═╡ 79b4d3c8-4867-499b-8aec-7fb2f84f419e


# ╔═╡ 1af310d4-12f0-4895-876c-eceed6b6fba5
md"""
# Sobre
"""

# ╔═╡ ae141be7-41de-46cb-9124-0311feb4e43e
md"""
## Autor
"""

# ╔═╡ 36f5fbe8-2f65-4747-9f4e-36158d87aac1
md"""

[**Ricardo Luís**](https://www.isel.pt/docentes/ricardo-jorge-ferreira-luis)

(Professor Adjunto, PhD)

\
**E-mail:** [ricardo.luis@isel.pt](mailto:ricardo.luis@isel.pt)

\
**Endereço postal:**

[ISEL](https://www.isel.pt/) - Instituto Superior de Engenharia de Lisboa\
Departamento de Engenharia Eletrotécnica de Energia e Automação\
Rua Conselheiro Emídio Navarro, 1\
1959-007 Lisboa, Portugal
"""

# ╔═╡ 86b344bc-719d-43bf-a0c8-fc0b35f26063


# ╔═╡ 2dedc485-5720-4553-b55e-2d5e0329124b
md"""
## Como citar
"""

# ╔═╡ e97fe045-3571-4b86-8022-d9870a45baf7
md"""
> **Ricardo Luís**. (2022). Documentos computacionais sobre Máquinas Elétricas II [coleção de *notebooks* de suporte a Máquinas Elétricas II, lecionada no curso LEE do ISEL]. Disponível: [https://ricardo-luis.github.io/me-ii](https://ricardo-luis.github.io/me-ii)

"""

# ╔═╡ 3af9f843-701b-4647-a183-8d63f0a726e5


# ╔═╡ 039c50af-bcb4-45a3-a028-efcfef2124b6
md"""
## Licenças
"""

# ╔═╡ d5427cae-3c95-4927-b8dd-1ba71a99b745
md"""
O material publicado neste *website* e respetivo repositório do GitHub, está licenciado da seguinte forma:

- As parcelas de código `Julia` dos *notebooks* estão sob os termos da licença: [MIT License](https://tldrlegal.com/license/mit-license)
- Os textos e outros conteúdos dos *notebooks* estão sob os termos da licença: [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/deed.pt) (CC BY-SA 4.0).


As suas [questões](https://github.com/Ricardo-Luis/me-ii/issues) e/ou [sugestões de melhoria](https://github.com/Ricardo-Luis/me-ii/pulls) sobre o(s) *notebook*(*s*) são bem-vindas.
"""

# ╔═╡ 329f957f-5031-4da9-93a8-2c6acd87ed76


# ╔═╡ a5004d56-6b46-49b9-bf7a-35d0a2749e6d
md"""
# Agradecimentos / Acknowledgements
Agradeço aos amigos e colegas do Grupo Disciplinar de Máquinas Elétricas do ISEL-DEEEA, pelas discussões e ideias para a realização de documentos computacionais, como material de apoio ao ensino da unidade curricular de Máquinas Elétricas II. 
"""

# ╔═╡ 151eccc5-745e-4b53-a4aa-00ed1a09ce1c
md"""
\
The design of this website is based on _**Computational Thinking**, a live online Julia/Pluto textbook._ [(computationalthinking.mit.edu)](https://computationalthinking.mit.edu). 

These online lectures on Computational Thinking using Pluto notebooks, inspired me to seek out and start developing a notebook collection on electrical machines studies in the electrical engineering course. 

My gratitude to the creators of [`Pluto.jl`](https://github.com/fonsp/Pluto.jl), Fons van der Plas and Mikołaj Bochenski and the entire team of contributors, who, due to the reactive characteristic of their notebook environment for scientific programming language `Julia`, made me use this type of computational document for teaching and research.
"""

# ╔═╡ cc5006d1-c8fb-4d34-863a-f1e5e5ce3147


# ╔═╡ 72c8086a-c513-4245-a00a-0a5a9da78ffb
md"""
# Setup
"""

# ╔═╡ f83478f1-ef46-4441-9f4f-fdac036563c9
TableOfContents(title="Índice", depth=6)

# ╔═╡ d6b646b9-d8e3-4ccf-bffe-201ca2f5353c
begin
	# other stuff:
	isel_logo="https://www.isel.pt/sites/default/files/NoPath%20-%20Copy%402x_0.png"
	julia_logo="https://github.com/JuliaLang/julia-logo-graphics/blob/master/images/julia-logo-color.png?raw=true"
	pluto_logo="https://raw.githubusercontent.com/fonsp/Pluto.jl/dd0ead4caa2d29a3a2cfa1196d31e3114782d363/frontend/img/logo_white_contour.svg"
end;

# ╔═╡ 4d3c1853-a689-44b3-808a-5b9b64515ca3
ThreeColumn(md"$(Resource(isel_logo, :height => 75))", md"
$\textbf{\color{green}{Lic. em Engenharia Eletrotécnica }}$", md"$\href{https://www.isel.pt/lee/maquinas-eletricas-ii}{\text{Máquinas Elétricas II}}$")

# ╔═╡ 83711275-a734-41d9-9074-b5bb54588dcb
md"""
**$(html"<p><center style='font-size:19px;font-family:monospace'>Documentos computacionais sobre Máquinas Elétricas II</center></p>")** 

| | | |
| :-: | :-: | :-: |
| $nbsp $nbsp $(Resource(julia_logo, :height => 34)) $nbsp $nbsp | $nbsp $nbsp $(Resource(pluto_logo, :height => 30))  $nbsp $nbsp | $nbsp $nbsp reactive notebooks  $nbsp $nbsp |
| | | |
| | | |
| | **Prof.** [**Ricardo Luís**](https://ricardo-luis.github.io/) | |
| | | |
"""

# ╔═╡ 962771f9-a228-4ffe-84f5-f078f1d1cd4d
md"""
---
"""

# ╔═╡ 31f9b5c0-ffc8-47a4-9d9a-874971ca0cb1
ThreeColumn(md"Text content: [![](https://i.creativecommons.org/l/by-sa/4.0/80x15.png)](http://creativecommons.org/licenses/by-sa/4.0/)", md" $(Resource(julia_logo, :height => 15)) `code`: [`MIT License`](https://www.tldrlegal.com/l/mit)", md"[$$© \text{ 2023 Ricardo Luís}$$](https://ricardo-luis.github.io)")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoTeachingTools = "~0.2.8"
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.4"
manifest_format = "2.0"
project_hash = "69f995e0dc6a1c35a46792be048dc8abd510ce38"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "d730914ef30a06732bdd9f763f6cc32e92ffbff1"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "6a125e6a4cb391e0b9adbd1afa9e771c2179f8ef"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.23"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "2422f47b34d4b127720a18f86fa7b1aa2e141f29"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.18"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "60168780555f3e663c536500aa790b6368adc02a"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "2.3.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "478ac6c952fddd4399e71d4779797c538d0ff2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.8"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

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
git-tree-sha1 = "b970826468465da71f839cdacc403e99842c18ea"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.8"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "Pkg", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "feafdc70b2e6684314e188d95fe66d116de834a7"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.5.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─4d3c1853-a689-44b3-808a-5b9b64515ca3
# ╟─83711275-a734-41d9-9074-b5bb54588dcb
# ╟─d4933445-95c9-4f86-a832-95278e8aa34c
# ╟─1eb0fa23-13f7-4dd2-b4b8-b8a6d802d90c
# ╟─659cda0d-61f1-4e65-b541-9d5e6c69bab2
# ╟─f3769341-6dcd-4332-a0a0-0cf79205f627
# ╟─0823c4d6-bf8a-4bb5-9719-385f8fe90684
# ╟─5fa1359a-5e2b-4d95-a09c-e32157b55a29
# ╟─79666f23-855e-4de8-b8b4-3f1c3fa0559c
# ╟─e4b2b337-b6cc-44e6-9aeb-0a206e553bf2
# ╟─b808fbbb-8468-41db-8095-d40fde95dfb5
# ╟─21e7517e-b11a-4c8d-a767-7f512257ccf9
# ╟─d27ed498-bac0-4724-976f-59404cd5d878
# ╟─fca14e55-3841-45cc-bb3e-150356724b44
# ╟─fc7938bc-f01a-46bb-b64c-7113cc019d01
# ╟─d2fe29e7-5a4b-4844-9ce1-0e2ef6687fdc
# ╟─93ab033c-e630-4789-8466-5ced9d4053eb
# ╟─03ea77a5-9a90-470f-8c8f-6fff2609f917
# ╟─25483496-477a-432a-abc9-db637bcd9ed2
# ╟─a933967e-0057-48a9-aa14-7220525b57c1
# ╟─2106627e-fa26-4869-8893-c3113b1ece12
# ╟─40c63f7b-db87-4b40-85a2-411e86b23bb6
# ╟─5a120f0e-e047-4af7-ab2a-179ccfa6557b
# ╟─2a7f669d-e085-4bd6-8fdb-dd60315a4101
# ╟─a312937f-7b82-42aa-bd00-04e289d154e8
# ╟─3fd8c7df-4aa0-49d6-a8e8-0c383b1b3947
# ╟─28512235-de44-4d62-9e3b-6e4cd4954a36
# ╟─f78860b7-b9db-44c5-bdbe-1d97ac7060bb
# ╟─fb8fae23-5360-466f-884a-b6626064a589
# ╟─0f360a8f-9a77-488d-a050-a95e8af83dfb
# ╟─e66d1b52-c2da-44c6-9dcf-60afbd397ed9
# ╟─4e5d5c46-6d98-4125-868f-548d28b96511
# ╟─ea2a84a1-7375-4933-a166-6bbd2eaa51e7
# ╟─45290d8f-5625-4796-adef-bc89554d827f
# ╟─33ee713c-2142-47b7-8bca-691c00ca4db4
# ╟─80b30983-2eb5-40f2-bbc3-c5a8b68ad8f8
# ╟─1a9de438-3a54-4739-9c70-e501f58f71e6
# ╟─37f6f655-412c-426d-9505-6bb5b269c612
# ╟─e7252dec-bd34-4186-b36a-111dea1ba96d
# ╟─79b4d3c8-4867-499b-8aec-7fb2f84f419e
# ╟─1af310d4-12f0-4895-876c-eceed6b6fba5
# ╟─ae141be7-41de-46cb-9124-0311feb4e43e
# ╟─36f5fbe8-2f65-4747-9f4e-36158d87aac1
# ╟─86b344bc-719d-43bf-a0c8-fc0b35f26063
# ╟─2dedc485-5720-4553-b55e-2d5e0329124b
# ╟─e97fe045-3571-4b86-8022-d9870a45baf7
# ╟─3af9f843-701b-4647-a183-8d63f0a726e5
# ╟─039c50af-bcb4-45a3-a028-efcfef2124b6
# ╟─d5427cae-3c95-4927-b8dd-1ba71a99b745
# ╟─329f957f-5031-4da9-93a8-2c6acd87ed76
# ╟─a5004d56-6b46-49b9-bf7a-35d0a2749e6d
# ╟─151eccc5-745e-4b53-a4aa-00ed1a09ce1c
# ╟─cc5006d1-c8fb-4d34-863a-f1e5e5ce3147
# ╟─72c8086a-c513-4245-a00a-0a5a9da78ffb
# ╠═766e42e6-0d19-48ba-b1a5-462708df3ff9
# ╠═f83478f1-ef46-4441-9f4f-fdac036563c9
# ╟─d6b646b9-d8e3-4ccf-bffe-201ca2f5353c
# ╟─962771f9-a228-4ffe-84f5-f078f1d1cd4d
# ╟─31f9b5c0-ffc8-47a4-9d9a-874971ca0cb1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
