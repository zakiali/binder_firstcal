FROM andrewosh/binder-base
MAINTAINER Zaki Ali <zakiali@berkeley.edu>


RUN conda install -y \
    astropy \
    basemap \
    ephem \
    matplotlib \
    numpy \
    psutil \
    psycopg2 \
    scipy \
    seaborn 

ADD hsa7458_v000.py .

RUN pip install -r requirements.txt

