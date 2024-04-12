enum ItineraryStatusEnum {
  ai_pending,
  ai_failure,
  draft,
  finalized,
  canceled,
  in_progress,
  completed;

  bool operator >(ItineraryStatusEnum other) => index > other.index;
  bool operator <(ItineraryStatusEnum other) => index < other.index;
  bool operator >=(ItineraryStatusEnum other) => index >= other.index;
  bool operator <=(ItineraryStatusEnum other) => index <= other.index;
}
