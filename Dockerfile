FROM registry.cn-hangzhou.aliyuncs.com/bewithmeallmylife/11.4.0-cudnn8-runtime-ubuntu18.04-conda-python3.8-qt5:1.0.0

USER root
ENV PATH /root/anaconda3/bin:$PATH
SHELL ["conda", "run", "-n", "python3.8", "/bin/bash", "-c"]
ENV LANGUAGE zh_CN:zh


RUN pip install peft>=0.3.0  -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install torch==2.0.1 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install transformers==4.35.0 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install sentencepiece==0.1.99 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install bitsandbytes==0.41.1 -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install scipy -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install gradio -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
RUN pip install mdtex2html -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com
WORKDIR /app/Chinese-LLaMA-Alpaca-2

ENV FORCE_CUDA="1"
ADD examples examples
ADD notebooks notebooks
ADD pics pics
ADD prompts prompts
ADD scripts scripts

#HF_ENDPOINT=https://hf-mirror.com python scripts/inference/inference_hf.py --base_model models/chinese-alpaca-2-1.3b-hf  --with_prompt --interactive

#sudo docker build -t='registry.cn-hangzhou.aliyuncs.com/bewithmeallmylife/chinese-llama-alpaca-2-app-cuda-11.4.0:1.0.0' .

#sudo docker run --net=host  --gpus '"device=0,1"' --privileged -it -v /home/xuwenfeng/app-sourcecode/LLM/models:/app/Chinese-LLaMA-Alpaca-2/models -d -u root registry.cn-hangzhou.aliyuncs.com/bewithmeallmylife/chinese-llama-alpaca-2-app-cuda-11.4.0:1.0.0