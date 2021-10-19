#!/bin/sh

set -eu

RASPBERRYPI_OS_IMG_BASE_URL="https://downloads.raspberrypi.org/raspios_lite_armhf/images"
RASPBERRYPI_OS_IMG_VERSION="raspios_lite_armhf-2021-05-28"
RASPBERRYPI_OS_ARCHIVE_NAME="2021-05-07-raspios-buster-armhf-lite.zip"
RASPBERRYPI_OS_IMAGE_NAME="2021-05-07-raspios-buster-armhf-lite.img"
RASPBERRYPI_OS_IMG_URL="${RASPBERRYPI_OS_IMG_BASE_URL}/${RASPBERRYPI_OS_IMG_VERSION}/${RASPBERRYPI_OS_ARCHIVE_NAME}"
# Integrity
INTEGRITY_HASH="c5dad159a2775c687e9281b1a0e586f7471690ae28f2f2282c90e7d59f64273c"
INTEGRITY_HASH_FILE_NAME="integrity_hash"
## RASPBERRYPI_OS_ARCHIVE_NAME="raspberrypi_os.img"

# Get image
curl -o ${RASPBERRYPI_OS_ARCHIVE_NAME} ${RASPBERRYPI_OS_IMG_URL}
# Integrity check
echo "${INTEGRITY_HASH} ${RASPBERRYPI_OS_ARCHIVE_NAME}" > "${INTEGRITY_HASH_FILE_NAME}"
sha256sum -c ${INTEGRITY_HASH_FILE_NAME}
# Extract image from archive
unzip ${RASPBERRYPI_OS_ARCHIVE_NAME}

#
losetup -Pf ${RASPBERRYPI_OS_IMAGE_NAME}

# Check status
LOSETUP_STATUS=$(losetup -j ${RASPBERRYPI_OS_IMAGE_NAME})
echo "losetup status is:"
echo "${LOSETUP_STATUS}"

# Get used loop device
LOOP_DEVICE=$(echo "${LOSETUP_STATUS}" | grep -o "\/dev\/loop[0-9]\+")
echo "loop device used is:"
echo "${LOOP_DEVICE}"

# Mount
mount "${LOOP_DEVICE}p2" /mnt

# Package to tar
tar cf root.tar -C /mnt .

# Unmount
umount /mnt
