---
# the default layout is 'page'
icon: fas fa-info-circle
order: 3
---

I'm **Abinaya Govindan**, Director of AI at [Neuron7.ai](https://www.neuron7.ai) and one of its two founding engineers. I've spent 11 years building AI and ML systems, and for the last several of them I've been working on one question:

> How do you get from an AI that *answers* to an AI that *delivers outcomes*?

This blog is where I write about that journey: the architecture, the trade-offs, and the engineering decisions behind production AI.

## My AI architecture journey

### 2015–2020 · From NLP research to product

I started at **BRIDGEi2i Analytics** in Applied NLP Labs, working my way from software engineer to module lead. This was the pre-LLM era of word embeddings (Word2Vec, GloVe), RNNs and LSTMs, and later BERT. The work was turning research into product modules:

- **Question answering over product manuals**, which taught me early that domain structure matters more than model size
- **Unsupervised named entity recognition** for the hi-tech domain
- **A human-in-the-loop continuous-learning framework** for NLU models, driven by expert feedback

The lesson that stuck: *models are only as good as the feedback loop around them.*

### 2020–2025 · Building an enterprise AI platform from zero

In 2020 I joined Neuron7 as a founding engineer and built its NLP and AI platform from the ground up. Over five years, retrieval evolved through almost every generation of the field:

- **fine-tuned classifiers and intent detection**, then
- **domain-tuned sentence-similarity models**, then
- **hybrid search (BM25 + vectors)** with multi-query expansion and ML reranking, then
- **fine-tuned small and mid-sized open-weight LLMs** for extraction, summarization, and noise removal, then
- **multimodal and web search tools** in a multi-tenant, real-time platform with production observability

Along the way I set the early engineering standards (CI/CD, testing, onboarding) and grew from ML engineer to ML architect.

### 2025–present · Agentic AI at enterprise scale

Today I lead the agentic AI charter at Neuron7: strategy, architecture, and the team that delivers it. The platform serves 20+ enterprise customers and 10,000+ active users. I've grown the India AI/ML organization from 3 to 32 engineers over time, across agent architecture, NLP/GenAI, search, backend, and AI infrastructure.

The problems I spend my time on:

- **Multi-agent architecture:** orchestrating memory, retrieval, and tool use across parallel agent nodes
- **Agent memory:** layered semantic (knowledge-graph), user-preference, and procedural memory
- **AI evaluation:** golden-query benchmarking and regression testing that actually predicts real-world quality
- **LLM economics:** prompt caching and multi-model routing, matching the model tier to how critical each step is
- **Retrieval at scale:** quantized vector search and self-hosted embeddings for cost and latency
- **Platform governance:** modular, independently releasable services and tenant isolation by default

## What I write about

- **AI Architecture:** reference designs and the decisions behind them
- **Agentic AI:** delegation, memory, tools, and the protocols that connect agents
- **RAG & Search:** retrieval, hybrid search, reranking, and grounding
- **AI Evaluation:** proving AI systems work, and keeping them working

Articles here are generic and architectural. They draw on hands-on experience but never on customer or proprietary details.

## Publications

- *Intelligent Question Answering Module for Product Manuals*, CS & IT (CSCP), 2021
- *Unsupervised Named Entity Recognition for Hi-Tech Domain*, CS & IT (CSCP), 2021
- *Continuous Learning Mechanism of NLU-ML Models Boosted by Human Feedback*, IEEE ICCIDS, 2019

## Education

B.E., Electronics & Communication, Madras Institute of Technology, Anna University, Chennai

## Get in touch

Find me on [LinkedIn](https://www.linkedin.com/in/abinaya-govindan-59088311a/) or [GitHub](https://github.com/abinaya-govindan).

*Views expressed here are my own and do not represent my employer.*
