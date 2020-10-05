# A Proposal for Specification Changes

## Definitions

- PartiQL implementation: An implementation of the PartiQL specification--i.e,
  at minimum, the parser, compiler and interpreter.
- PartiQL service: A software component that combines PartiQL with data sources
  such as a OLTP storage engine or data warehouse.

## Background

In an ideal world when a new feature is added to the PartiQL language the
process for doing so would be:

- The PartiQL specification is updated *first*.
- *Then* the new feature is added to the reference implementation.  

However, this doesn't always work out so well because:

  prototype to prove the proposed behavior is implementable or desirable.  Some
- It is often difficult to precisely specify new features if there is no
  experimentation may be required in order to know the best way for a new
  feature to be implemented.
- The time and resources of the PartiQL steering committee may not be
  immediately available to review every proposal in depth, and to re-review as
  changes to the proposed features are discovered during implementation.
- There may not be enough time to update the specification before delivery of a
  new feature.

To address these concerns, we should we adopt a process for revising the
specification.

## PartiQL Specification Requests

The term `PSR`: stands for PartiQL Specification Request.  PSRs are documents
that describe proposed changes to the PartiQL specification.  They exist as
documents that reside in the
[`partiql-spec`](https://github.com/partiql/partiql-spec) GitHub repository.
Examples of PSRs might include proposals to:

- Add a `LET` sub-clause in various SFW queries
- Add syntax for invocation of stored procedures
- Clarify any ambiguous part of the specification (Only if clarification results
  in changes to the reference implementation.  If no changes to the reference
  implementation are needed then a standard GitHub PR should be submitted.

PSRs may be submitted by any party.

## PSR Process

1. The requester should create a document according the template in the `psr`
  subdirectory of the main specification's
  [repository](https://github.com/partiql/partiql-spec) and a GitHub pull
  request.
2. The PartiQL steering committee may review and recommend changes to the PSR
  before the PR is merged and implementation begins. 
3. A new "feature flag" should then be added to the [PartiQL reference
  implementation](https://github.com/partiql/partiql-lang-kotlin)
    - A feature flag is a boolean configuration option that defaults to off.  
    - Feature flags allow a PartiQL implementation to have experimental features
      that are not enabled by default, thus preventing end-users from taking
      dependencies on experimental features that are not fully finalized.
    - When the feature flag is off and an attempt to use the corresponding
      feature is made, the implementation must raise an error condition which
      indicates the feature flag must be explicitly enabled to use the feature.
4. The PSR then should be implemented.
5. If the PSR could not be implemented *exactly* as described, the PSR should be
   revised and steps 2-4 repeated as needed.
6. The PartiQL implementation should be released.
7. The feature should be enabled in a PartiQL service and customer feedback
   should be collected.
8. If the customer feedback indicates that additional changes are needed, revise
   the PSR and repeat steps 2-8.
9. Create a GitHub pull request to revise the formal specification with the
   changes outlined in the PSR.

   
![PSR Flowchar](psr-process.jpeg)

<!-- 

To edit this flowchart:

- Navigate to ttps://mermaid-js.github.io 
- Paste in the graph definition below
- Revise as needed.
- Replace the revised graph below
- Replace `psr-process.jpeg`

graph TD
    SubmitPSR[Submit PSR] -->  ReviewPSR(Review by partiql team and committee rep)
    ReviewPSR -->|Review and revise| ReviewPSR[Review PSR]
    ReviewPSR --> ImplementPSR
    ImplementPSR[Implement PSR behind feature flag] --> Deviated
    Deviated{Did the <br>implementation <br>deviate?} --> |No|ReleasePartiQL
    Deviated -->|Yes|RevisePSR2
    RevisePSR[Revise the PSR] --> ReviewPSR
    RevisePSR2[Revise the PSR] --> ReviewPSR
    ReleasePartiQL[Release PartiQL] --> CustomerFeedback
    CustomerFeedback[Collect Customer Feedback] -->
    ChangesNeeded{Are changes <br> needed after customer <br>  feedback?} -->|Yes|RevisePSR
    ChangesNeeded-->|No|UpdateFormalSpec --> RemoveFF[Remove feature flag]
    UpdateFormalSpec[Submit PR to update formal specification]
  

-->

