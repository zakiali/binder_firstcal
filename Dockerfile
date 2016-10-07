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
    seaborn \

RUN git clone git@github.com:zakiali/capo.git && cd capo && python ./setup.py install && cd -

RUN git clone git@github.com:zakiali/omnical.git && cd omnical && python .setup.py install && cd - 

RUN git clone git@github.com:zakiali/capo.git && cd capo && python ./setup.py install && cd -

COPY hsa7458_v000.py .

