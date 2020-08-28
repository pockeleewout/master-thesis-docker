#/usr/bin/env bash

alias echo="echo -e"

if [ ! -d /project/ ]; then
	echo "FATAL: /project/ does not exist"
	exit 1
fi

# Make sure that we have a model name defined
if [ "x${TRAIN_MODEL}" == "x" ]; then
	export TRAIN_MODEL=default;
fi

# Export some names for reuse

export LOGS_TGZ="logs-${TRAIN_MODEL}.tgz"
export RECO_TGZ="reconstructions-${TRAIN_MODEL}.tgz"

export PROJECT="/project/ewout/CapsNet"
export PROJECT_GIT="https://github.com/pockeleewout/CapsNet.git"



if [ ! -d ${PROJECT}/ ]; then
	echo "Cloning code repository..."
	if [ -d /project_scratch/ ]; then
		cd /project_scratch/
		git clone "${PROJECT_GIT}"
		echo "Copying repository to project directory..."
		cp -rf "CapsNet/" "/project/ewout/"
	else
		cd "${PROJECT}/.."
		git clone "${PROJECT_GIT}"
	fi
	# Make sure a new-line is printed
	echo ""
fi

if [ -d /project_scratch/ ]; then
	echo "Copying project files to scratch..."
	cp -rf ${PROJECT} /project_scratch/
	echo "Setting directory to project scratch..."
	cd /project_scratch/CapsNet/
else
	echo "Setting directory to project..."
	cd ${PROJECT}/
fi
echo ""



echo "Starting training, with options '${TRAIN_OPTS}' for model '${TRAIN_MODEL}'\n"
python3 train.py ${TRAIN_OPTS} --model ${TRAIN_MODEL}
echo "Training finished\n"



echo "Exporting logs to archive"
if [ -e "${LOGS_TGZ}" ]; then
	echo "Removing old archive"
	rm "${LOGS_TGZ}"
fi
tar -czf "${LOGS_TGZ}" "logs/"
rm -r logs/
echo ""

echo "Exporting reconstructions to archive"
if [ -e "${RECO_TGZ}" ]; then
	echo "Removing old archive"
	rm "${RECO_TGZ}"
fi
tar -czf "${RECO_TGZ}" "reconstructions/"
rm -r "reconstructions/"
echo ""



if [ -e "/project_scratch/CapsNet/${LOGS_TGZ}" ]; then
	echo "Copying log files to permanent project storage"
	cp "/project_scratch/CapsNet/${LOGS_TGZ}" "${PROJECT}/"
	echo ""
fi

if [ -e "/project_scratch/CapsNet/${RECO_TGZ}" ]; then
	echo "Copying reconstructions to permanent project storage"
	cp "/project_scratch/CapsNet/${RECO_TGZ}" "${PROJECT}/"
	echo ""
fi

