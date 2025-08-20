# BoutiqueAI Command Center: Implementation Plan

This document outlines the development and implementation plan for the BoutiqueAI Command Center, a multi-agent system to enhance the Online Boutique application.

---

## **Phase 0: Project Setup & Foundation**

The goal of this phase is to establish the basic structure for our new AI services.

1.  **Create `plan.md`:**
    *   [x] This file, to track our progress.

2.  **Create AI Services Directory:**
    *   [ ] Create a new directory `src/boutiqueai` to house all the new AI agent microservices.

3.  **Establish Agent-to-Agent (A2A) Communication:**
    *   [ ] Define a common gRPC protocol or a lightweight Pub/Sub mechanism for agents to communicate with each other.
    *   [ ] Create a shared library in Python that all agents can use to simplify communication.

---

## **Phase 1: Layer 1 - The AI Concierge (MVP)**

The goal is to get a basic, non-LLM version of the AI Concierge running to validate the core integrations.

1.  **Scaffold the `aiconcierge` Microservice:**
    *   [ ] Create the directory `src/boutiqueai/aiconcierge`.
    *   [ ] Define its gRPC API in a `.proto` file for handling user conversations and actions.
    *   [ ] Implement a basic Python gRPC server.

2.  **Integrate with Existing Services:**
    *   [ ] Connect to the `ProductCatalogService` to retrieve product information.
    *   [ ] Connect to the `CartService` to add items to a user's cart.

3.  **Deployment:**
    *   [ ] Write a `Dockerfile` to containerize the service.
    *   [ ] Create Kubernetes manifests (`deployment.yaml`, `service.yaml`) to deploy the service to GKE.

---

## **Phase 2: Layer 2 - The Business Operations Agents**

The goal is to build the background agents that will provide real-time intelligence.

1.  **The "Proactive Inventory" Manager:**
    *   [ ] Scaffold the `inventorymanager` microservice in `src/boutiqueai/inventorymanager`.
    *   [ ] Implement logic to periodically check stock levels from the `ProductCatalogService`.
    *   [ ] Create a mock supplier API for "reordering" products.
    *   [ ] Implement A2A communication to broadcast stock level warnings.
    *   [ ] Containerize and create Kubernetes manifests.

2.  **The "Impulse AI" Promotions Strategist:**
    *   [ ] Scaffold the `promotionsstrategist` microservice in `src/boutiqueai/promotionsstrategist`.
    *   [ ] Implement logic to identify products that need a sales boost.
    *   [ ] Integrate with the **Gemini API** to generate creative promotion ideas (e.g., "15% off for the next hour!").
    *   [ ] Use the `CartService` API to apply discounts. *(Note: We may need to investigate if the existing API supports this directly.)*
    *   [ ] Implement A2A communication to inform the AI Concierge of active promotions.
    *   [ ] Containerize and create Kubernetes manifests.

---

## **Phase 3: Enhancing the AI Concierge with Gemini**

The goal is to make the AI Concierge truly intelligent and conversational.

1.  **Integrate Gemini for NLU:**
    *   [ ] Connect the `aiconcierge` service to the **Gemini API**.
    *   [ ] Use Gemini to understand complex, multi-turn user requests.

2.  **Enable Context-Aware Responses:**
    *   [ ] Modify the `aiconcierge` to listen for A2A messages from the Inventory and Promotions agents.
    *   [ ] Use this real-time context to answer questions like, "Are there any special deals on cameras that you have in stock right now?"

---

## **Phase 4: Layer 3 - The MLOps Agent (The "AI Supervisor")**

The goal is to create the meta-agent that automates and optimizes the entire system.

1.  **The A/B Test Automator:**
    *   [ ] Scaffold the `mlopsagent` microservice in `src/boutiqueai/mlopsagent`.
    *   [ ] Create the infrastructure to deploy two versions of the `aiconcierge` model in GKE.
    *   [ ] Implement a method to monitor key performance metrics (e.g., conversion rates) for each version.
    *   [ ] Use the **Gemini API** to analyze the performance data and determine the winning model.
    *   [ ] Integrate with **kubectl-ai** or the Kubernetes API to automatically shift 100% of traffic to the better-performing model.
    *   [ ] Containerize and create Kubernetes manifests.

---

## **Phase 5: Final Integration & Demo Prep**

The goal is to polish the project and prepare for the final presentation.

1.  **End-to-End Testing:**
    *   [ ] Perform thorough testing of the entire multi-agent workflow.
2.  **Documentation:**
    *   [ ] Create a comprehensive `README.md` for the BoutiqueAI system.
3.  **Demo Script:**
    *   [ ] Prepare a compelling demo script that showcases the full power of the system, from customer interaction to autonomous optimization.
