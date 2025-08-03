### A Pluto.jl notebook ###
# v0.20.13

using Markdown
using InteractiveUtils

# ╔═╡ 766e42e6-0d19-48ba-b1a5-462708df3ff9
using PlutoUI, PlutoTeachingTools  	# packages needed for this notebook

# ╔═╡ ffe5e74c-8167-41c7-bc35-4c412081a757


# ╔═╡ b08af239-c9d1-43c3-b150-e80f06801efd


# ╔═╡ d4933445-95c9-4f86-a832-95278e8aa34c
md"""

# Introdução 

Este *website* disponibiliza a leitura e o acesso a uma coleção de *notebooks* na forma de notas de aula e cálculos de engenharia, de apoio à unidade curricular de Máquinas Elétricas II, lecionada no curso de Licenciatura em Engenharia Eletrotécnica do Instituto Superior de Engenharia de Lisboa.

Os *notebooks* são documentos computacionais que utilizam o navegador *web*, integrando o desenvolvimento e os resultados computacionais, com texto explicativo, expressões matemáticas, tabelas, imagens, entre outros, de forma interligada e interativa com o utilizador. Esta metodologia procura integrar a aprendizagem teórica com as características operacionais das máquinas elétricas.

Estes *notebooks* são desenvolvidos utilizando o **Pluto.jl**, um ambiente de desenvolvimento integrado simples e reativo para a linguagem de computação científica `Julia`. Esta abordagem imersiva permite aos estudantes explorar conceitos complexos de forma dinâmica, estabelecendo pontes entre o conhecimento académico e os desafios reais da engenharia. O objetivo é facilitar uma compreensão mais profunda e prática da matéria, contribuindo para o desenvolvimento de competências essenciais ao exercício da engenharia.
"""

# ╔═╡ 1eb0fa23-13f7-4dd2-b4b8-b8a6d802d90c


# ╔═╡ 659cda0d-61f1-4e65-b541-9d5e6c69bab2
md"""
# 🎈 Notebooks de ME II:
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
# Instalação de *software*
"""

# ╔═╡ 5fa1359a-5e2b-4d95-a09c-e32157b55a29
md"""
## Julia

### Linha de comandos

### Manual
"""

# ╔═╡ f78860b7-b9db-44c5-bdbe-1d97ac7060bb


# ╔═╡ ff1ebc33-1a81-470b-8044-d09a0faec8e6
md"""
## Pluto.jl
Siga as instruções presentes no *website* do [Pluto.jl](https://plutojl.org/#install).
De forma sintética siga os seguintes passos.
"""

# ╔═╡ 8e8a5310-1518-4578-9173-e83a7d540737
md"""
Para instalar o ambiente de desenvolvimento Pluto.jl, executar na linha de comando do Julia:
"""

# ╔═╡ a078a168-b48b-46bf-b1a6-6b106616c586
md"""
	import Pkg; Pkg.add("Pluto")
"""

# ╔═╡ 8e883eba-aed5-4d0d-8846-e440a9f6ee4f
md"""
Para abrir o ambiente de desenvolvimento Pluto.jl, executar na linha de comando do Julia:
"""

# ╔═╡ e77f2489-a0e5-4aeb-a577-e86c353fdf0c
md"""
	import Pluto; Pluto.run()
"""

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

# ╔═╡ 2dedc485-5720-4553-b55e-2d5e0329124b
md"""
## Como citar
"""

# ╔═╡ e97fe045-3571-4b86-8022-d9870a45baf7
md"""
	Luís, Ricardo (2025). Notebooks Computacionais Aplicados a Máquinas Elétricas II. Instituto Superior de Engenharia de Lisboa, Licenciatura em Engenharia Eletrotécnica. Disponível em: https://ricardo-luis.github.io/me-2
"""

# ╔═╡ b9468a1a-f715-45a2-81d5-a580622880cb


# ╔═╡ 039c50af-bcb4-45a3-a028-efcfef2124b6
md"""
## Licenças
"""

# ╔═╡ d5427cae-3c95-4927-b8dd-1ba71a99b745
md"""
O material publicado neste *website* e respetivo repositório do GitHub, está licenciado da seguinte forma:

- As parcelas de código `Julia` dos *notebooks* estão sob os termos da licença: [MIT License](https://tldrlegal.com/license/mit-license)
- Os textos e outros conteúdos dos *notebooks* estão sob os termos da licença: [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/deed.pt) (CC BY-SA 4.0).


As suas [questões](https://github.com/Ricardo-Luis/me-2/issues) e/ou [sugestões de melhoria](https://github.com/Ricardo-Luis/me-2/pulls) sobre o(s) *notebook*(*s*) são bem-vindas.
"""

# ╔═╡ 329f957f-5031-4da9-93a8-2c6acd87ed76


# ╔═╡ a5004d56-6b46-49b9-bf7a-35d0a2749e6d
md"""
# Agradecimentos / Acknowledgements

Agradeço aos amigos e colegas do Grupo Disciplinar de Máquinas Elétricas do ISEL-DEEEA, pelas discussões e ideias que contribuíram para a conceção e desenvolvimento destes documentos computacionais, como material de apoio ao ensino da unidade curricular de Máquinas Elétricas II.

Um reconhecimento especial aos criadores do Pluto.jl, Fons van der Plas e Mikołaj Bochenski, bem como a toda a equipa de contribuidores. A característica reactiva do seu ambiente de notebooks para a linguagem de programação científica `Julia` possibilitou a adopção de *notebooks* computacionais para o ensino e investigação em máquinas eléctricas.

Expresso também o meu apreço à comunidade `Julia` e aos programadores das bibliotecas utilizadas nestes notebooks, cujo trabalho colaborativo enriquece constantemente as possibilidades educativas desta plataforma.

---

I thank my friends and colleagues from the Electrical Machines Teaching Group at ISEL-DEEEA for the discussions and ideas that contributed to the conception and development of these computational documents as support material for teaching the Electrical Machines II course.

Special acknowledgment goes to the creators of Pluto.jl, Fons van der Plas and Mikołaj Bochenski, as well as the entire team of contributors. The reactive nature of their notebook environment for the Julia scientific programming language made it possible to adopt this type of computational notebook for teaching and research in electrical machines.

I also express my gratitude to the `Julia` community and the developers of the libraries used in these notebooks, whose collaborative work constantly enriches the educational possibilities of this platform.
"""

# ╔═╡ cc5006d1-c8fb-4d34-863a-f1e5e5ce3147
HTML("""
<div style="text-align: right; font-style: italic; margin-top: 10px;">
Ricardo Luís
</div>
""")

# ╔═╡ 72c8086a-c513-4245-a00a-0a5a9da78ffb
md"""
# *Setup*
"""

# ╔═╡ f83478f1-ef46-4441-9f4f-fdac036563c9
TableOfContents(title="Índice") 	# to generate the Table of Contents from Markdown cells

# ╔═╡ 99e9e1a5-29b4-4660-9e5c-8b70b25c5497
# to adjust the notebook margins and used font-family/size on text content
html"""<style>
@media screen {
	main {
		margin: auto;
		max-width: 1920px;
		padding-left: 5%;
		padding-right: 25.9%; 
		}
	}
pluto-output {
    font-family: system-ui;
	font-size:  100%
}
</style>
"""

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
	        height=85
	    ),
	    "julia" => (
	        light="https://github.com/Ricardo-Luis/me-2/blob/main/images/julia.svg?raw=true",
	        dark="https://github.com/Ricardo-Luis/me-2/blob/main/images/julia_dark.svg?raw=true",
	        height=48
	    ),
		"pluto" => (
	        light="https://github.com/Ricardo-Luis/me-2/blob/main/images/pluto.svg?raw=true",
	        dark="https://github.com/Ricardo-Luis/me-2/blob/main/images/pluto.svg?raw=true",
	        height=35
		)
	)
	
	# Links correspondentes
	my_links = Dict(
	    "isel" => "https://www.isel.pt",
	    "julia" => "https://julialang.org",
		"pluto" => "https://plutojl.org"
	)
end;

# ╔═╡ c4c3c88d-e13f-4782-9131-eb0d70b5277d
TwoColumnWideLeft(logo_adaptativo(my_logos, my_links, default_logo="isel"),
    md"""
    $$\begin{align}
    \\[-3mm]
    \small{\textsf{Licenciatura em Engenharia Eletrotécnica}} \\
    \href{https://www.isel.pt/sites/default/files/FUC_202425_3894.pdf}{\text{Máquinas Elétricas II}}
    \end{align}$$
    """
)

# ╔═╡ 054f60fc-9f3b-49c7-8f0e-c94dd6595000
md"""
**$(html"<p><center style='font-size:25px;font-family:monospace'>Notebooks Computacionais Aplicados a Máquinas Elétricas II</center></p>")** 

| | | |
| :-: | :-: | :-: |
| $$\quad$$ **Linguagem de computação científica** $$\quad$$ | $$\quad$$ **Ambiente de desenvolvimento**  $$\quad$$ | $$\quad$$ **_Notebooks_**  $$\quad$$ |
| | | |
| | | |
| $$\quad$$ $(logo_adaptativo(my_logos, my_links, default_logo="julia")) $$\quad$$ | $$\quad$$ $(logo_adaptativo(my_logos, my_links, default_logo="pluto")) $$\quad$$ | $$\quad$$ [reativos, reproduzíveis, interativos](#🎈-Notebooks-de-ME-II:) $$\quad$$ |
| | | |
| | | |
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
# ╟─ffe5e74c-8167-41c7-bc35-4c412081a757
# ╟─054f60fc-9f3b-49c7-8f0e-c94dd6595000
# ╟─b08af239-c9d1-43c3-b150-e80f06801efd
# ╟─d4933445-95c9-4f86-a832-95278e8aa34c
# ╟─1eb0fa23-13f7-4dd2-b4b8-b8a6d802d90c
# ╟─659cda0d-61f1-4e65-b541-9d5e6c69bab2
# ╟─f3769341-6dcd-4332-a0a0-0cf79205f627
# ╟─0823c4d6-bf8a-4bb5-9719-385f8fe90684
# ╠═5fa1359a-5e2b-4d95-a09c-e32157b55a29
# ╟─f78860b7-b9db-44c5-bdbe-1d97ac7060bb
# ╟─ff1ebc33-1a81-470b-8044-d09a0faec8e6
# ╟─8e8a5310-1518-4578-9173-e83a7d540737
# ╟─a078a168-b48b-46bf-b1a6-6b106616c586
# ╟─8e883eba-aed5-4d0d-8846-e440a9f6ee4f
# ╟─e77f2489-a0e5-4aeb-a577-e86c353fdf0c
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
# ╠═36f5fbe8-2f65-4747-9f4e-36158d87aac1
# ╟─2dedc485-5720-4553-b55e-2d5e0329124b
# ╟─e97fe045-3571-4b86-8022-d9870a45baf7
# ╟─b9468a1a-f715-45a2-81d5-a580622880cb
# ╟─039c50af-bcb4-45a3-a028-efcfef2124b6
# ╟─d5427cae-3c95-4927-b8dd-1ba71a99b745
# ╟─329f957f-5031-4da9-93a8-2c6acd87ed76
# ╟─a5004d56-6b46-49b9-bf7a-35d0a2749e6d
# ╟─cc5006d1-c8fb-4d34-863a-f1e5e5ce3147
# ╟─72c8086a-c513-4245-a00a-0a5a9da78ffb
# ╠═766e42e6-0d19-48ba-b1a5-462708df3ff9
# ╠═f83478f1-ef46-4441-9f4f-fdac036563c9
# ╟─99e9e1a5-29b4-4660-9e5c-8b70b25c5497
# ╟─e785e52d-3662-4e9f-a932-b01dac732421
# ╟─c6d64e49-3d58-41a6-bdd3-62cddc7e86d6
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
