#!/bin/bash
# HTF 2025 Team 8 - Aqua Topia Container Build and Push Script
# Builds container image and pushes to quay.io registry

set -euo pipefail

# ============================================
# Configuration
# ============================================
REGISTRY="quay.io"
NAMESPACE="htf25-team8"
IMAGE_NAME="aqua-topia"
TAG="${1:-latest}"
FULL_IMAGE="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ============================================
# Functions
# ============================================
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_podman() {
    if ! command -v podman &> /dev/null; then
        log_error "Podman is not installed. Please install podman first."
        exit 1
    fi
    log_info "Podman version: $(podman --version)"
}

check_registry_login() {
    log_info "Checking registry login status..."
    if podman login --get-login "${REGISTRY}" &> /dev/null; then
        local username
        username=$(podman login --get-login "${REGISTRY}")
        log_info "Already logged in to ${REGISTRY} as ${username}"
        return 0
    else
        log_warn "Not logged in to ${REGISTRY}"
        log_info "Attempting to log in..."
        if ! podman login "${REGISTRY}"; then
            log_error "Failed to log in to ${REGISTRY}"
            exit 1
        fi
    fi
}

build_image() {
    log_info "Building container image: ${FULL_IMAGE}"

    if podman build \
        --tag "${FULL_IMAGE}" \
        --file Containerfile \
        --format docker \
        --layers \
        --force-rm \
        .; then
        log_info "Build successful!"
    else
        log_error "Build failed!"
        exit 1
    fi
}

push_image() {
    log_info "Pushing image to registry: ${FULL_IMAGE}"

    if podman push "${FULL_IMAGE}"; then
        log_info "Push successful!"
    else
        log_error "Push failed!"
        exit 1
    fi
}

verify_image() {
    log_info "Verifying local image..."
    if podman image exists "${FULL_IMAGE}"; then
        log_info "Image exists locally"
        podman inspect "${FULL_IMAGE}" --format '{{.Id}}' | cut -c1-12
    else
        log_error "Image not found locally"
        exit 1
    fi
}

display_summary() {
    echo ""
    log_info "============================================"
    log_info "Build and Push Summary"
    log_info "============================================"
    log_info "Image:     ${FULL_IMAGE}"
    log_info "Registry:  ${REGISTRY}"
    log_info "Namespace: ${NAMESPACE}"
    log_info "Tag:       ${TAG}"
    log_info "============================================"
    echo ""
    log_info "To pull this image on the webserver, run:"
    echo "  podman pull ${FULL_IMAGE}"
    echo ""
    log_info "To run this image locally, run:"
    echo "  podman run -d -p 8080:8080 --name aqua-topia ${FULL_IMAGE}"
    echo ""
}

# ============================================
# Main Execution
# ============================================
main() {
    log_info "Starting build and push process for Team 8 Aqua Topia"

    # Change to script directory
    cd "$(dirname "$0")"

    # Verify prerequisites
    check_podman
    check_registry_login

    # Build and push
    build_image
    verify_image
    push_image

    # Display summary
    display_summary

    log_info "Build and push completed successfully!"
}

# Run main function
main "$@"
