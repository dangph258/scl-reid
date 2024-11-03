#!/bin/bash
DATASET=$1
#LABELED use only for cuhk03 dataset, TRUE: Labeled, FALSE: Detected
LABELED=$2
BS=$3
LOG_FOLDER=$4

USE_CENTER_LOSS=$5
CENTER_LOSS_WEIGHT=$6
USE_XENT_LOSS=$7
XENT_LOSS_WEIGHT=$8
USE_CONTRASTIVE_LOSS=$9
CONTRASTIVE_LOSS_WEIGHT=${10}
USE_CENTROID_CONTRASTIVE_LOSS=${11}
CENTROID_CONTRASTIVE_WEIGHT=${12}
USE_SUPERVISED_CONTRASTIVE_LOSS=${13}
SUPERVISED_CONTRASTIVE_LOSS_WEIGHT=${14}

IMS_PER_BATCH=$(($BS / 4))

# python -m debugpy --listen 5678 train_ctl_model.py \
python train_ctl_model.py \
--config_file="configs/256_resnet50_384_192.yml" \
GPU_IDS [0] \
DATASETS.NAMES $DATASET \
DATASETS.LABELED $LABELED \
DATASETS.ROOT_DIR './data' \
SOLVER.IMS_PER_BATCH ${IMS_PER_BATCH} \
TEST.IMS_PER_BATCH 128 \
SOLVER.BASE_LR 0.00035 \
OUTPUT_DIR $LOG_FOLDER \
DATALOADER.USE_RESAMPLING False \
USE_MIXED_PRECISION False \
SOLVER.EVAL_PERIOD 20 \
SOLVER.USE_CENTER_LOSS $USE_CENTER_LOSS \
SOLVER.CENTER_LOSS_WEIGHT $CENTER_LOSS_WEIGHT \
SOLVER.USE_XENT_LOSS $USE_XENT_LOSS \
SOLVER.XENT_LOSS_WEIGHT $XENT_LOSS_WEIGHT \
SOLVER.USE_CONTRASTIVE_LOSS $USE_CONTRASTIVE_LOSS \
SOLVER.CONTRASTIVE_LOSS_WEIGHT $CONTRASTIVE_LOSS_WEIGHT \
SOLVER.USE_CENTROID_CONTRASTIVE_LOSS $USE_CENTROID_CONTRASTIVE_LOSS \
SOLVER.CENTROID_CONTRASTIVE_WEIGHT $CENTROID_CONTRASTIVE_WEIGHT \
SOLVER.USE_SUPERVISED_CONTRASTIVE_LOSS $USE_SUPERVISED_CONTRASTIVE_LOSS \
SOLVER.SUPERVISED_CONTRASTIVE_LOSS_WEIGHT $SUPERVISED_CONTRASTIVE_LOSS_WEIGHT \
SOLVER.MAX_EPOCHS 120 \
REPRODUCIBLE_NUM_RUNS 1 \
2>&1 | tee $LOG_FOLDER/log.txt