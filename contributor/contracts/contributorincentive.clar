;; Contributor Incentive System - A token system for rewarding open-source contributions
(define-constant contract-owner tx-sender)

;; Define the token
(define-fungible-token contributor-token)

;; Error codes
(define-constant err-permission-denied (err u100))
(define-constant err-funds-insufficient (err u101))
(define-constant err-amount-invalid (err u102))

;; Data variables
(define-map developer-pledges principal uint)
(define-map developer-incentives principal uint)

;; Read-only functions
(define-read-only (get-balance (developer principal))
  (ft-get-balance contributor-token developer))

(define-read-only (get-pledge (developer principal))
  (default-to u0 (map-get? developer-pledges developer)))

(define-read-only (get-incentive (developer principal))
  (default-to u0 (map-get? developer-incentives developer)))

;; Public functions
(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-permission-denied)
    (ft-mint? contributor-token amount recipient)))

(define-public (submit-contribution (amount uint))
  (ft-burn? contributor-token amount tx-sender))

(define-public (grant-incentive (developer principal) (amount uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-permission-denied)
    (map-set developer-incentives developer (+ (get-incentive developer) amount))
    (ft-mint? contributor-token amount developer)))

(define-public (pledge-tokens (amount uint))
  (begin
    (asserts! (>= (ft-get-balance contributor-token tx-sender) amount) err-funds-insufficient)
    (asserts! (> amount u0) err-amount-invalid)
    (map-set developer-pledges tx-sender (+ (get-pledge tx-sender) amount))
    (ft-burn? contributor-token amount tx-sender)))

(define-public (revoke-pledge (amount uint))
  (begin
    (asserts! (>= (get-pledge tx-sender) amount) err-funds-insufficient)
    (asserts! (> amount u0) err-amount-invalid)
    (map-set developer-pledges tx-sender (- (get-pledge tx-sender) amount))
    (ft-mint? contributor-token amount tx-sender)))

(define-public (claim-incentive)
  (let ((incentive-amount (get-incentive tx-sender)))
    (begin
      (asserts! (> incentive-amount u0) err-amount-invalid)
      (map-set developer-incentives tx-sender u0)
      (ft-mint? contributor-token incentive-amount tx-sender))))
