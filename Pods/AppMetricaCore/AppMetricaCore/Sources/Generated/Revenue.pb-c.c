/* Generated by the protocol buffer compiler.  DO NOT EDIT! */
/* Generated from: Revenue.proto */

/* Do not generate deprecated warnings for self */
#ifndef PROTOBUF_C__NO_DEPRECATED
#define PROTOBUF_C__NO_DEPRECATED
#endif

#include "Revenue.pb-c.h"
void   ama__revenue__receipt__init
                     (Ama__Revenue__Receipt         *message)
{
  static const Ama__Revenue__Receipt init_value = AMA__REVENUE__RECEIPT__INIT;
  *message = init_value;
}
void   ama__revenue__transaction__init
                     (Ama__Revenue__Transaction         *message)
{
  static const Ama__Revenue__Transaction init_value = AMA__REVENUE__TRANSACTION__INIT;
  *message = init_value;
}
void   ama__revenue__subscription_info__period__init
                     (Ama__Revenue__SubscriptionInfo__Period         *message)
{
  static const Ama__Revenue__SubscriptionInfo__Period init_value = AMA__REVENUE__SUBSCRIPTION_INFO__PERIOD__INIT;
  *message = init_value;
}
void   ama__revenue__subscription_info__introductory__init
                     (Ama__Revenue__SubscriptionInfo__Introductory         *message)
{
  static const Ama__Revenue__SubscriptionInfo__Introductory init_value = AMA__REVENUE__SUBSCRIPTION_INFO__INTRODUCTORY__INIT;
  *message = init_value;
}
void   ama__revenue__subscription_info__init
                     (Ama__Revenue__SubscriptionInfo         *message)
{
  static const Ama__Revenue__SubscriptionInfo init_value = AMA__REVENUE__SUBSCRIPTION_INFO__INIT;
  *message = init_value;
}
void   ama__revenue__init
                     (Ama__Revenue         *message)
{
  static const Ama__Revenue init_value = AMA__REVENUE__INIT;
  *message = init_value;
}
size_t ama__revenue__get_packed_size
                     (const Ama__Revenue *message)
{
  assert(message->base.descriptor == &ama__revenue__descriptor);
  return protobuf_c_message_get_packed_size ((const ProtobufCMessage*)(message));
}
size_t ama__revenue__pack
                     (const Ama__Revenue *message,
                      uint8_t       *out)
{
  assert(message->base.descriptor == &ama__revenue__descriptor);
  return protobuf_c_message_pack ((const ProtobufCMessage*)message, out);
}
size_t ama__revenue__pack_to_buffer
                     (const Ama__Revenue *message,
                      ProtobufCBuffer *buffer)
{
  assert(message->base.descriptor == &ama__revenue__descriptor);
  return protobuf_c_message_pack_to_buffer ((const ProtobufCMessage*)message, buffer);
}
Ama__Revenue *
       ama__revenue__unpack
                     (ProtobufCAllocator  *allocator,
                      size_t               len,
                      const uint8_t       *data)
{
  return (Ama__Revenue *)
     protobuf_c_message_unpack (&ama__revenue__descriptor,
                                allocator, len, data);
}
void   ama__revenue__free_unpacked
                     (Ama__Revenue *message,
                      ProtobufCAllocator *allocator)
{
  if(!message)
    return;
  assert(message->base.descriptor == &ama__revenue__descriptor);
  protobuf_c_message_free_unpacked ((ProtobufCMessage*)message, allocator);
}
static const ProtobufCFieldDescriptor ama__revenue__receipt__field_descriptors[2] =
{
  {
    "data",
    1,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_BYTES,
    offsetof(Ama__Revenue__Receipt, has_data),
    offsetof(Ama__Revenue__Receipt, data),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "transaction_id",
    3,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_BYTES,
    offsetof(Ama__Revenue__Receipt, has_transaction_id),
    offsetof(Ama__Revenue__Receipt, transaction_id),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
};
static const unsigned ama__revenue__receipt__field_indices_by_name[] = {
  0,   /* field[0] = data */
  1,   /* field[1] = transaction_id */
};
static const ProtobufCIntRange ama__revenue__receipt__number_ranges[2 + 1] =
{
  { 1, 0 },
  { 3, 1 },
  { 0, 2 }
};
const ProtobufCMessageDescriptor ama__revenue__receipt__descriptor =
{
  PROTOBUF_C__MESSAGE_DESCRIPTOR_MAGIC,
  "ama.Revenue.Receipt",
  "Receipt",
  "Ama__Revenue__Receipt",
  "ama",
  sizeof(Ama__Revenue__Receipt),
  2,
  ama__revenue__receipt__field_descriptors,
  ama__revenue__receipt__field_indices_by_name,
  2,  ama__revenue__receipt__number_ranges,
  (ProtobufCMessageInit) ama__revenue__receipt__init,
  NULL,NULL,NULL    /* reserved[123] */
};
static const ProtobufCEnumValue ama__revenue__transaction__state__enum_values_by_number[3] =
{
  { "STATE_UNDEFINED", "AMA__REVENUE__TRANSACTION__STATE__STATE_UNDEFINED", 0 },
  { "PURCHASED", "AMA__REVENUE__TRANSACTION__STATE__PURCHASED", 1 },
  { "RESTORED", "AMA__REVENUE__TRANSACTION__STATE__RESTORED", 2 },
};
static const ProtobufCIntRange ama__revenue__transaction__state__value_ranges[] = {
{0, 0},{0, 3}
};
static const ProtobufCEnumValueIndex ama__revenue__transaction__state__enum_values_by_name[3] =
{
  { "PURCHASED", 1 },
  { "RESTORED", 2 },
  { "STATE_UNDEFINED", 0 },
};
const ProtobufCEnumDescriptor ama__revenue__transaction__state__descriptor =
{
  PROTOBUF_C__ENUM_DESCRIPTOR_MAGIC,
  "ama.Revenue.Transaction.State",
  "State",
  "Ama__Revenue__Transaction__State",
  "ama",
  3,
  ama__revenue__transaction__state__enum_values_by_number,
  3,
  ama__revenue__transaction__state__enum_values_by_name,
  1,
  ama__revenue__transaction__state__value_ranges,
  NULL,NULL,NULL,NULL   /* reserved[1234] */
};
static const Ama__Revenue__Transaction__State ama__revenue__transaction__state__default_value = AMA__REVENUE__TRANSACTION__STATE__STATE_UNDEFINED;
static const ProtobufCFieldDescriptor ama__revenue__transaction__field_descriptors[5] =
{
  {
    "id",
    1,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_BYTES,
    offsetof(Ama__Revenue__Transaction, has_id),
    offsetof(Ama__Revenue__Transaction, id),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "time",
    2,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_UINT64,
    offsetof(Ama__Revenue__Transaction, has_time),
    offsetof(Ama__Revenue__Transaction, time),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "state",
    3,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_ENUM,
    offsetof(Ama__Revenue__Transaction, has_state),
    offsetof(Ama__Revenue__Transaction, state),
    &ama__revenue__transaction__state__descriptor,
    &ama__revenue__transaction__state__default_value,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "secondary_id",
    4,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_BYTES,
    offsetof(Ama__Revenue__Transaction, has_secondary_id),
    offsetof(Ama__Revenue__Transaction, secondary_id),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "secondary_time",
    5,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_UINT64,
    offsetof(Ama__Revenue__Transaction, has_secondary_time),
    offsetof(Ama__Revenue__Transaction, secondary_time),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
};
static const unsigned ama__revenue__transaction__field_indices_by_name[] = {
  0,   /* field[0] = id */
  3,   /* field[3] = secondary_id */
  4,   /* field[4] = secondary_time */
  2,   /* field[2] = state */
  1,   /* field[1] = time */
};
static const ProtobufCIntRange ama__revenue__transaction__number_ranges[1 + 1] =
{
  { 1, 0 },
  { 0, 5 }
};
const ProtobufCMessageDescriptor ama__revenue__transaction__descriptor =
{
  PROTOBUF_C__MESSAGE_DESCRIPTOR_MAGIC,
  "ama.Revenue.Transaction",
  "Transaction",
  "Ama__Revenue__Transaction",
  "ama",
  sizeof(Ama__Revenue__Transaction),
  5,
  ama__revenue__transaction__field_descriptors,
  ama__revenue__transaction__field_indices_by_name,
  1,  ama__revenue__transaction__number_ranges,
  (ProtobufCMessageInit) ama__revenue__transaction__init,
  NULL,NULL,NULL    /* reserved[123] */
};
static const ProtobufCEnumValue ama__revenue__subscription_info__period__time_unit__enum_values_by_number[5] =
{
  { "UNKNOWN", "AMA__REVENUE__SUBSCRIPTION_INFO__PERIOD__TIME_UNIT__UNKNOWN", 0 },
  { "DAY", "AMA__REVENUE__SUBSCRIPTION_INFO__PERIOD__TIME_UNIT__DAY", 1 },
  { "WEEK", "AMA__REVENUE__SUBSCRIPTION_INFO__PERIOD__TIME_UNIT__WEEK", 2 },
  { "MONTH", "AMA__REVENUE__SUBSCRIPTION_INFO__PERIOD__TIME_UNIT__MONTH", 3 },
  { "YEAR", "AMA__REVENUE__SUBSCRIPTION_INFO__PERIOD__TIME_UNIT__YEAR", 4 },
};
static const ProtobufCIntRange ama__revenue__subscription_info__period__time_unit__value_ranges[] = {
{0, 0},{0, 5}
};
static const ProtobufCEnumValueIndex ama__revenue__subscription_info__period__time_unit__enum_values_by_name[5] =
{
  { "DAY", 1 },
  { "MONTH", 3 },
  { "UNKNOWN", 0 },
  { "WEEK", 2 },
  { "YEAR", 4 },
};
const ProtobufCEnumDescriptor ama__revenue__subscription_info__period__time_unit__descriptor =
{
  PROTOBUF_C__ENUM_DESCRIPTOR_MAGIC,
  "ama.Revenue.SubscriptionInfo.Period.TimeUnit",
  "TimeUnit",
  "Ama__Revenue__SubscriptionInfo__Period__TimeUnit",
  "ama",
  5,
  ama__revenue__subscription_info__period__time_unit__enum_values_by_number,
  5,
  ama__revenue__subscription_info__period__time_unit__enum_values_by_name,
  1,
  ama__revenue__subscription_info__period__time_unit__value_ranges,
  NULL,NULL,NULL,NULL   /* reserved[1234] */
};
static const ProtobufCFieldDescriptor ama__revenue__subscription_info__period__field_descriptors[2] =
{
  {
    "number",
    1,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_UINT32,
    offsetof(Ama__Revenue__SubscriptionInfo__Period, has_number),
    offsetof(Ama__Revenue__SubscriptionInfo__Period, number),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "time_unit",
    2,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_ENUM,
    offsetof(Ama__Revenue__SubscriptionInfo__Period, has_time_unit),
    offsetof(Ama__Revenue__SubscriptionInfo__Period, time_unit),
    &ama__revenue__subscription_info__period__time_unit__descriptor,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
};
static const unsigned ama__revenue__subscription_info__period__field_indices_by_name[] = {
  0,   /* field[0] = number */
  1,   /* field[1] = time_unit */
};
static const ProtobufCIntRange ama__revenue__subscription_info__period__number_ranges[1 + 1] =
{
  { 1, 0 },
  { 0, 2 }
};
const ProtobufCMessageDescriptor ama__revenue__subscription_info__period__descriptor =
{
  PROTOBUF_C__MESSAGE_DESCRIPTOR_MAGIC,
  "ama.Revenue.SubscriptionInfo.Period",
  "Period",
  "Ama__Revenue__SubscriptionInfo__Period",
  "ama",
  sizeof(Ama__Revenue__SubscriptionInfo__Period),
  2,
  ama__revenue__subscription_info__period__field_descriptors,
  ama__revenue__subscription_info__period__field_indices_by_name,
  1,  ama__revenue__subscription_info__period__number_ranges,
  (ProtobufCMessageInit) ama__revenue__subscription_info__period__init,
  NULL,NULL,NULL    /* reserved[123] */
};
static const ProtobufCFieldDescriptor ama__revenue__subscription_info__introductory__field_descriptors[4] =
{
  {
    "price_micros",
    1,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_INT64,
    offsetof(Ama__Revenue__SubscriptionInfo__Introductory, has_price_micros),
    offsetof(Ama__Revenue__SubscriptionInfo__Introductory, price_micros),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "period",
    2,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_MESSAGE,
    0,   /* quantifier_offset */
    offsetof(Ama__Revenue__SubscriptionInfo__Introductory, period),
    &ama__revenue__subscription_info__period__descriptor,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "number_of_periods",
    3,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_UINT32,
    offsetof(Ama__Revenue__SubscriptionInfo__Introductory, has_number_of_periods),
    offsetof(Ama__Revenue__SubscriptionInfo__Introductory, number_of_periods),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "id",
    4,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_BYTES,
    offsetof(Ama__Revenue__SubscriptionInfo__Introductory, has_id),
    offsetof(Ama__Revenue__SubscriptionInfo__Introductory, id),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
};
static const unsigned ama__revenue__subscription_info__introductory__field_indices_by_name[] = {
  3,   /* field[3] = id */
  2,   /* field[2] = number_of_periods */
  1,   /* field[1] = period */
  0,   /* field[0] = price_micros */
};
static const ProtobufCIntRange ama__revenue__subscription_info__introductory__number_ranges[1 + 1] =
{
  { 1, 0 },
  { 0, 4 }
};
const ProtobufCMessageDescriptor ama__revenue__subscription_info__introductory__descriptor =
{
  PROTOBUF_C__MESSAGE_DESCRIPTOR_MAGIC,
  "ama.Revenue.SubscriptionInfo.Introductory",
  "Introductory",
  "Ama__Revenue__SubscriptionInfo__Introductory",
  "ama",
  sizeof(Ama__Revenue__SubscriptionInfo__Introductory),
  4,
  ama__revenue__subscription_info__introductory__field_descriptors,
  ama__revenue__subscription_info__introductory__field_indices_by_name,
  1,  ama__revenue__subscription_info__introductory__number_ranges,
  (ProtobufCMessageInit) ama__revenue__subscription_info__introductory__init,
  NULL,NULL,NULL    /* reserved[123] */
};
static const ProtobufCFieldDescriptor ama__revenue__subscription_info__field_descriptors[3] =
{
  {
    "auto_renewing",
    1,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_BOOL,
    offsetof(Ama__Revenue__SubscriptionInfo, has_auto_renewing),
    offsetof(Ama__Revenue__SubscriptionInfo, auto_renewing),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "subscription_period",
    2,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_MESSAGE,
    0,   /* quantifier_offset */
    offsetof(Ama__Revenue__SubscriptionInfo, subscription_period),
    &ama__revenue__subscription_info__period__descriptor,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "introductory_info",
    3,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_MESSAGE,
    0,   /* quantifier_offset */
    offsetof(Ama__Revenue__SubscriptionInfo, introductory_info),
    &ama__revenue__subscription_info__introductory__descriptor,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
};
static const unsigned ama__revenue__subscription_info__field_indices_by_name[] = {
  0,   /* field[0] = auto_renewing */
  2,   /* field[2] = introductory_info */
  1,   /* field[1] = subscription_period */
};
static const ProtobufCIntRange ama__revenue__subscription_info__number_ranges[1 + 1] =
{
  { 1, 0 },
  { 0, 3 }
};
const ProtobufCMessageDescriptor ama__revenue__subscription_info__descriptor =
{
  PROTOBUF_C__MESSAGE_DESCRIPTOR_MAGIC,
  "ama.Revenue.SubscriptionInfo",
  "SubscriptionInfo",
  "Ama__Revenue__SubscriptionInfo",
  "ama",
  sizeof(Ama__Revenue__SubscriptionInfo),
  3,
  ama__revenue__subscription_info__field_descriptors,
  ama__revenue__subscription_info__field_indices_by_name,
  1,  ama__revenue__subscription_info__number_ranges,
  (ProtobufCMessageInit) ama__revenue__subscription_info__init,
  NULL,NULL,NULL    /* reserved[123] */
};
static const ProtobufCEnumValue ama__revenue__buyer_device__enum_values_by_number[3] =
{
  { "BUYER_UNDEFINED", "AMA__REVENUE__BUYER_DEVICE__BUYER_UNDEFINED", 0 },
  { "THIS", "AMA__REVENUE__BUYER_DEVICE__THIS", 1 },
  { "ANOTHER", "AMA__REVENUE__BUYER_DEVICE__ANOTHER", 2 },
};
static const ProtobufCIntRange ama__revenue__buyer_device__value_ranges[] = {
{0, 0},{0, 3}
};
static const ProtobufCEnumValueIndex ama__revenue__buyer_device__enum_values_by_name[3] =
{
  { "ANOTHER", 2 },
  { "BUYER_UNDEFINED", 0 },
  { "THIS", 1 },
};
const ProtobufCEnumDescriptor ama__revenue__buyer_device__descriptor =
{
  PROTOBUF_C__ENUM_DESCRIPTOR_MAGIC,
  "ama.Revenue.BuyerDevice",
  "BuyerDevice",
  "Ama__Revenue__BuyerDevice",
  "ama",
  3,
  ama__revenue__buyer_device__enum_values_by_number,
  3,
  ama__revenue__buyer_device__enum_values_by_name,
  1,
  ama__revenue__buyer_device__value_ranges,
  NULL,NULL,NULL,NULL   /* reserved[1234] */
};
static const ProtobufCEnumValue ama__revenue__in_app_type__enum_values_by_number[2] =
{
  { "PURCHASE", "AMA__REVENUE__IN_APP_TYPE__PURCHASE", 1 },
  { "SUBSCRIPTION", "AMA__REVENUE__IN_APP_TYPE__SUBSCRIPTION", 2 },
};
static const ProtobufCIntRange ama__revenue__in_app_type__value_ranges[] = {
{1, 0},{0, 2}
};
static const ProtobufCEnumValueIndex ama__revenue__in_app_type__enum_values_by_name[2] =
{
  { "PURCHASE", 0 },
  { "SUBSCRIPTION", 1 },
};
const ProtobufCEnumDescriptor ama__revenue__in_app_type__descriptor =
{
  PROTOBUF_C__ENUM_DESCRIPTOR_MAGIC,
  "ama.Revenue.InAppType",
  "InAppType",
  "Ama__Revenue__InAppType",
  "ama",
  2,
  ama__revenue__in_app_type__enum_values_by_number,
  2,
  ama__revenue__in_app_type__enum_values_by_name,
  1,
  ama__revenue__in_app_type__value_ranges,
  NULL,NULL,NULL,NULL   /* reserved[1234] */
};
static const uint32_t ama__revenue__quantity__default_value = 1u;
static const protobuf_c_boolean ama__revenue__auto_collected__default_value = 0;
static const Ama__Revenue__InAppType ama__revenue__in_app_type__default_value = AMA__REVENUE__IN_APP_TYPE__PURCHASE;
static const ProtobufCFieldDescriptor ama__revenue__field_descriptors[10] =
{
  {
    "quantity",
    1,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_UINT32,
    offsetof(Ama__Revenue, has_quantity),
    offsetof(Ama__Revenue, quantity),
    NULL,
    &ama__revenue__quantity__default_value,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "currency",
    3,
    PROTOBUF_C_LABEL_REQUIRED,
    PROTOBUF_C_TYPE_BYTES,
    0,   /* quantifier_offset */
    offsetof(Ama__Revenue, currency),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "product_id",
    4,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_BYTES,
    offsetof(Ama__Revenue, has_product_id),
    offsetof(Ama__Revenue, product_id),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "payload",
    5,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_BYTES,
    offsetof(Ama__Revenue, has_payload),
    offsetof(Ama__Revenue, payload),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "receipt",
    6,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_MESSAGE,
    0,   /* quantifier_offset */
    offsetof(Ama__Revenue, receipt),
    &ama__revenue__receipt__descriptor,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "price_micros",
    7,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_INT64,
    offsetof(Ama__Revenue, has_price_micros),
    offsetof(Ama__Revenue, price_micros),
    NULL,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "auto_collected",
    8,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_BOOL,
    offsetof(Ama__Revenue, has_auto_collected),
    offsetof(Ama__Revenue, auto_collected),
    NULL,
    &ama__revenue__auto_collected__default_value,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "in_app_type",
    10,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_ENUM,
    offsetof(Ama__Revenue, has_in_app_type),
    offsetof(Ama__Revenue, in_app_type),
    &ama__revenue__in_app_type__descriptor,
    &ama__revenue__in_app_type__default_value,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "transaction_info",
    11,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_MESSAGE,
    0,   /* quantifier_offset */
    offsetof(Ama__Revenue, transaction_info),
    &ama__revenue__transaction__descriptor,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
  {
    "subscription_info",
    12,
    PROTOBUF_C_LABEL_OPTIONAL,
    PROTOBUF_C_TYPE_MESSAGE,
    0,   /* quantifier_offset */
    offsetof(Ama__Revenue, subscription_info),
    &ama__revenue__subscription_info__descriptor,
    NULL,
    0,             /* flags */
    0,NULL,NULL    /* reserved1,reserved2, etc */
  },
};
static const unsigned ama__revenue__field_indices_by_name[] = {
  6,   /* field[6] = auto_collected */
  1,   /* field[1] = currency */
  7,   /* field[7] = in_app_type */
  3,   /* field[3] = payload */
  5,   /* field[5] = price_micros */
  2,   /* field[2] = product_id */
  0,   /* field[0] = quantity */
  4,   /* field[4] = receipt */
  9,   /* field[9] = subscription_info */
  8,   /* field[8] = transaction_info */
};
static const ProtobufCIntRange ama__revenue__number_ranges[3 + 1] =
{
  { 1, 0 },
  { 3, 1 },
  { 10, 7 },
  { 0, 10 }
};
const ProtobufCMessageDescriptor ama__revenue__descriptor =
{
  PROTOBUF_C__MESSAGE_DESCRIPTOR_MAGIC,
  "ama.Revenue",
  "Revenue",
  "Ama__Revenue",
  "ama",
  sizeof(Ama__Revenue),
  10,
  ama__revenue__field_descriptors,
  ama__revenue__field_indices_by_name,
  3,  ama__revenue__number_ranges,
  (ProtobufCMessageInit) ama__revenue__init,
  NULL,NULL,NULL    /* reserved[123] */
};
